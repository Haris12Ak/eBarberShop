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

        public RezervacijaService(ApplicationDbContext dbContext, IMapper mapper, IKorisniciService korisniciService, IUposlenikService uposlenikService, IMessageProducer messageProducer) : base(dbContext, mapper)
        {
            _korisniciService = korisniciService;
            _uposlenikService = uposlenikService;
            _messageProducer = messageProducer;
        }

        public override async Task<Model.PagedResult<Model.Rezervacija>> Get(RezervacijaSearch? search)
        {
            var query = _dbContext.Set<Database.Rezervacija>().Include(x => x.Uposlenik).AsQueryable();

            PagedResult<Model.Rezervacija> result = new PagedResult<Model.Rezervacija>();

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

            result.Count = await query.CountAsync();

            if (search?.PageSize.HasValue == true && search?.Page.HasValue == true)
            {
                query = query.Take(search.PageSize.Value).Skip(search.Page.Value * search.PageSize.Value);
            }

            var list = await query.OrderBy(x => x.Datum).OrderBy(y => y.Vrijeme).ToListAsync();

            result.Result = _mapper.Map<List<Model.Rezervacija>>(list);

            return result;
        }

        public override IQueryable<Database.Rezervacija> AddInclude(IQueryable<Database.Rezervacija> query, RezervacijaSearch? search)
        {
            if (search?.IsUslugeIncluded == true)
            {
                query = query.Include("RezervacijaUsluge.Usluga");
            }

            return base.AddInclude(query, search);
        }

        public override async Task<Model.Rezervacija> Delete(int id)
        {
            var rezervacija = await _dbContext.Set<Database.Rezervacija>().FindAsync(id);

            if (rezervacija == null)
                return null;

            _dbContext.RezervacijaUsluge.RemoveRange(rezervacija.RezervacijaUsluge);

            _dbContext.Rezervacija.Remove(rezervacija);
            await _dbContext.SaveChangesAsync();

            return _mapper.Map<Model.Rezervacija>(rezervacija);
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

        public async Task<Model.Rezervacija> RezervisiTermin(int uslugaId, RezervacijaInsertRequest request)
        {
            var korisnik = await _korisniciService.GetById(request.KorisnikId);

            if (korisnik == null)
                return null;

            var uposlenik = await _uposlenikService.GetById(request.UposlenikId);

            if (uposlenik == null)
                return null;

            bool isUposlenikDostupan = await IsUposlenikDostupan(uposlenik.UposlenikId, request.Datum, request.Vrijeme);

            if (!isUposlenikDostupan)
                throw new UserException("Odabrani uposlenik " + uposlenik.Ime + uposlenik.Prezime + " nije dostupan.Molimo odaberite drugog uposlenika ili drugi termin.");

            var rezervacija = new Database.Rezervacija()
            {
                Datum = request.Datum,
                Vrijeme = request.Vrijeme,
                Status = request.Status,
                KorisnikId = korisnik.KorisniciId,
                UposlenikId = uposlenik.UposlenikId,
            };

            var usluga = await _dbContext.Set<Database.Usluga>().FindAsync(uslugaId);

            if (usluga == null)
                return null;

            await _dbContext.Rezervacija.AddAsync(rezervacija);

            rezervacija.RezervacijaUsluge.Add(new Database.RezervacijaUsluge()
            {
                Usluga = usluga,
                Rezervacija = rezervacija
            });

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
    }
}
