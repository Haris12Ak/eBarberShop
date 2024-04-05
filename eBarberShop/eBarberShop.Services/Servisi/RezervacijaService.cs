using AutoMapper;
using eBarberShop.Model;
using eBarberShop.Model.Requests;
using eBarberShop.Model.Search;
using eBarberShop.Services.Interfejsi;
using Microsoft.EntityFrameworkCore;

namespace eBarberShop.Services.Servisi
{
    public class RezervacijaService : BaseCRUDService<Model.Rezervacija, Database.Rezervacija, Model.Search.RezervacijaSearch, Model.Requests.RezervacijaInsertRequest, Model.Requests.RezervacijaUpdateRequest>, IRezervacijaService
    {
        private readonly IMessageProducer _messageProducer;
        private readonly IKorisniciService _korisniciService;
        private readonly IUposlenikService _uposlenikService;
        private readonly IUslugaService _uslugaService;

        public RezervacijaService(ApplicationDbContext dbContext, IMapper mapper, IKorisniciService korisniciService, IUposlenikService uposlenikService, IMessageProducer messageProducer, IUslugaService uslugaService) : base(dbContext, mapper)
        {
            _korisniciService = korisniciService;
            _uposlenikService = uposlenikService;
            _messageProducer = messageProducer;
            _uslugaService = uslugaService;
        }

        public override IQueryable<Database.Rezervacija> AddFilter(IQueryable<Database.Rezervacija> query, RezervacijaSearch? search)
        {
            if (search?.Datum.HasValue == true)
            {
                query = query.Where(x => x.Datum.Date == search.Datum.Value.Date);
            }

            if (!string.IsNullOrWhiteSpace(search?.ImePrezimeUposlenika))
            {
                query = query.Where(x => (x.Uposlenik.Ime.ToLower() + " " + x.Uposlenik.Prezime.ToLower()).StartsWith(search.ImePrezimeUposlenika.ToLower())
                || (x.Uposlenik.Prezime.ToLower() + " " + x.Uposlenik.Ime.ToLower()).StartsWith(search.ImePrezimeUposlenika.ToLower())
                );
            }

            if (!string.IsNullOrWhiteSpace(search?.ImePrezimeKorisnika))
            {
                query = query.Where(x => (x.Korisnik.Ime.ToLower() + " " + x.Korisnik.Prezime.ToLower()).StartsWith(search.ImePrezimeKorisnika.ToLower())
                || (x.Korisnik.Prezime.ToLower() + " " + x.Korisnik.Ime.ToLower()).StartsWith(search.ImePrezimeKorisnika.ToLower())
                );
            }

            if (!string.IsNullOrWhiteSpace(search?.NazivUsluge))
            {
                query = query.Where(x => x.Usluga.Naziv.ToLower().StartsWith(search.NazivUsluge.ToLower()));
            }

            return base.AddFilter(query, search);
        }

        public override IQueryable<Database.Rezervacija> AddInclude(IQueryable<Database.Rezervacija> query, RezervacijaSearch? search)
        {
            if (search?.IsKorisnikIncluded == true)
            {
                query = query.Include("Korisnik");
            }

            if (search?.IsUposlenikIncluded == true)
            {
                query = query.Include("Uposlenik");
            }

            if (search?.IsUslugaIncluded == true)
            {
                query = query.Include("Usluga");
            }

            return base.AddInclude(query, search);
        }

        public async Task<List<Termini>> GetTermine(TerminiSearch? search)
        {
            var query = _dbContext.Rezervacija.AsQueryable();

            if (search?.Datum.HasValue == true)
            {
                query = query.Where(x => x.Datum.Date == search.Datum.Value.Date);
            }

            var data = await query.OrderBy(x => x.Datum).OrderBy(y => y.Vrijeme).ToListAsync();

            return _mapper.Map<List<Model.Termini>>(data);
        }

        public async override Task<Rezervacija> Insert(RezervacijaInsertRequest insert)
        {
            var korisnik = await _korisniciService.GetById(insert.KorisnikId);

            if (korisnik == null)
                return null;

            var usluga = await _uslugaService.GetById(insert.UslugaId);

            if (usluga == null)
                return null;

            var uposlenik = await _uposlenikService.GetById(insert.UposlenikId);

            if (uposlenik == null)
                return null;

            bool isUposlenikDostupan = await IsUposlenikDostupan(uposlenik.UposlenikId, insert.Datum, insert.Vrijeme);

            if (!isUposlenikDostupan)
                throw new UserException("Odabrani uposlenik " + uposlenik.Ime + uposlenik.Prezime + " nije dostupan.Molimo odaberite drugog uposlenika ili drugi termin.");

            var rezervacija = new Database.Rezervacija()
            {
                Datum = insert.Datum,
                Vrijeme = insert.Vrijeme,
                Status = insert.Status,
                KorisnikId = korisnik.KorisniciId,
                UposlenikId = uposlenik.UposlenikId,
                UslugaId = usluga.UslugaId
            };

            await _dbContext.Rezervacija.AddAsync(rezervacija);

            await _dbContext.SaveChangesAsync();

            Model.ReservationNotifier reservationNotifier = new ReservationNotifier()
            {
                Id = rezervacija.RezervacijaId,
                UposlenikIme = uposlenik.Ime,
                UposlenikPrezime = uposlenik.Prezime,
                UslugaNaziv = usluga.Naziv,
                KorisnikIme = korisnik.Ime,
                CijenaUsluge = usluga.Cijena,
                Email = korisnik.Email,
                Datum = rezervacija.Datum,
                Vrijeme = rezervacija.Vrijeme
            };

            _messageProducer.SendingObject(reservationNotifier);

            return _mapper.Map<Model.Rezervacija>(rezervacija);
        }

        private async Task<bool> IsUposlenikDostupan(int uposlenikId, DateTime datum, DateTime vrijeme)
        {
            var odabraniUposlenik = await _dbContext.Set<Database.Rezervacija>().FirstOrDefaultAsync(x => x.UposlenikId == uposlenikId && x.Datum.Date == datum.Date && x.Vrijeme == vrijeme);

            if (odabraniUposlenik != null)
                return false;
            else
                return true;
        }

        public async Task<List<TerminiKorisnikaInfo>> GetTermineByKorisnikId(int korisnikId)
        {
            var set = _dbContext.Set<Database.Rezervacija>();

            var currentDateTime = DateTime.Now;

            var entity = await set.Where(x => x.KorisnikId == korisnikId)
                .Include("Usluga")
                .Select(y => new TerminiKorisnikaInfo()
                {
                    RezervacijaId = y.RezervacijaId,
                    Datum = y.Datum,
                    Vrijeme = y.Vrijeme,
                    NazivUsluge = y.Usluga.Naziv,
                    IsAktivna = (y.Datum.Date > currentDateTime.Date ||
                                           (y.Datum.Date == currentDateTime.Date && y.Vrijeme.TimeOfDay > currentDateTime.TimeOfDay))
                                           ? true
                                           : false,
                })
                .OrderByDescending(z => z.Vrijeme)
                .ToListAsync();

            return entity;
        }
    }
}
