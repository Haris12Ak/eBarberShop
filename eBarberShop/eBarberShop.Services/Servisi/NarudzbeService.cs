using AutoMapper;
using eBarberShop.Model;
using eBarberShop.Model.Requests;
using eBarberShop.Model.Search;
using eBarberShop.Services.Interfejsi;
using Microsoft.EntityFrameworkCore;

namespace eBarberShop.Services.Servisi
{
    public class NarudzbeService : BaseCRUDService<Model.Narudzbe, Database.Narudzbe, Model.Search.NarudzbeSearch, Model.Requests.NarudzbeInsertRequest, Model.Requests.NarudzbeUpdateRequest>, INarudzbeService
    {
        private readonly IKorisniciService _korisniciService;
        private readonly IProizvodiService _proizvodiService;
        public NarudzbeService(ApplicationDbContext dbContext, IMapper mapper, IKorisniciService korisniciService, IProizvodiService proizvodiService) : base(dbContext, mapper)
        {
            _korisniciService = korisniciService;
            _proizvodiService = proizvodiService;
        }

        public override IQueryable<Database.Narudzbe> AddFilter(IQueryable<Database.Narudzbe> query, NarudzbeSearch? search)
        {
            if (!string.IsNullOrWhiteSpace(search?.BrojNarudzbe))
            {
                query = query.Where(x => x.BrojNarudzbe.ToLower().Contains(search.BrojNarudzbe.ToLower()));
            }

            if (search?.DatumNarudzbe.HasValue == true)
            {
                query = query.Where(x => x.DatumNarudzbe.Date == search.DatumNarudzbe.Value.Date);
            }

            return base.AddFilter(query, search);
        }

        public override IQueryable<Database.Narudzbe> AddInclude(IQueryable<Database.Narudzbe> query, NarudzbeSearch? search)
        {
            if (search?.isKorisnikIncluded == true)
            {
                query = query.Include("Korisnik.Grad");
            }
            return base.AddInclude(query, search);
        }

        public async override Task<Narudzbe> Insert(NarudzbeInsertRequest insert)
        {
            var set = _dbContext.Set<Database.Narudzbe>();

            var korisnik = await _korisniciService.GetById(insert.KorisnikId);

            if (korisnik == null)
            {
                return null;
            }

            string orderNumber = Helper.NumberGenerator.GenerateNumber();

            var entity = new Database.Narudzbe()
            {
                BrojNarudzbe = orderNumber,
                DatumNarudzbe = insert.DatumNarudzbe,
                UkupanIznos = insert.UkupanIznos,
                Status = insert.Status,
                Otkazano = insert.Otkazano,
                KorisnikId = korisnik.KorisniciId
            };

            await set.AddAsync(entity);

            await _dbContext.SaveChangesAsync();

            return _mapper.Map<Model.Narudzbe>(entity);
        }

        public async Task<IzvjestajNarudzbe> GetIzvjestajNarudzbe(IzvjestajNarudzbeSearch? search)
        {
            var query = _dbContext.Set<Database.Narudzbe>()
                .Include("Korisnik")
                .Include("NarudzbeDetalji")
                .AsQueryable();


            if (search?.DatumOd.HasValue == true && search.DatumDo.HasValue == true)
            {
                if (search.DatumOd.Value.Date >= search.DatumDo.Value.Date)
                    throw new UserException("Datum OD mora biti manji od datuma DO");

                query = query.Where(x => x.DatumNarudzbe.Date >= search.DatumOd.Value.Date && x.DatumNarudzbe.Date <= search.DatumDo.Value.Date);
            }

            var listOfOrders = await query.ToListAsync();

            var groupOrders = listOfOrders
                .GroupBy(group => group.DatumNarudzbe.Date)
                .Select(y => new NarudzbaIfno()
                {
                    DatumNarudzbe = y.Key,
                    Narudzbe = y.Select(narudzba => new Model.ListOfNarudzbe()
                    {
                        BrojNarudzbe = narudzba.BrojNarudzbe,
                        Naplata = narudzba.UkupanIznos,
                        KorisnikId = narudzba.KorisnikId,
                        ImeKorisnika = narudzba.Korisnik?.Ime,
                        PrezimeKorisnika = narudzba.Korisnik?.Prezime
                    }).ToList(),
                    UkupanIznos = y.Sum(sum => sum.UkupanIznos)
                })
                .OrderBy(z => z.DatumNarudzbe.Date)
                .ToList();

            decimal total = 0;

            foreach (var item in listOfOrders)
            {
                total += item.UkupanIznos;
            }

            var productQuantitySold = new Dictionary<int, int>();

            foreach (var order in listOfOrders)
            {
                foreach (var orderDetail in order.NarudzbeDetalji)
                {
                    if (productQuantitySold.ContainsKey(orderDetail.ProizvodId))
                    {
                        productQuantitySold[orderDetail.ProizvodId] += orderDetail.Kolicina;
                    }
                    else
                    {
                        productQuantitySold.Add(orderDetail.ProizvodId, orderDetail.Kolicina);
                    }
                }
            }

            int bestSellingProductId = productQuantitySold.OrderByDescending(x => x.Value).FirstOrDefault().Key;

            var bestSellingProduct = await _proizvodiService.GetById(bestSellingProductId);

            var createReport = new IzvjestajNarudzbe()
            {
                Ukupno = total,
                NajviseProdavaniProizvod = bestSellingProduct != null ? bestSellingProduct.Naziv : "Proizvod nije pronaden!",
                NarudzbaInfo = groupOrders,
            };

            return createReport;
        }

        public async Task<List<Narudzbe>> GetNarudzbeByKorisnikId(int korisnikId, DateTime? datumNarudzbe)
        {
            var query = _dbContext.Set<Database.Narudzbe>().Where(x => x.KorisnikId == korisnikId).AsQueryable();

            if (datumNarudzbe.HasValue == true)
            {
                query = query.Where(y => y.DatumNarudzbe.Date == datumNarudzbe.Value.Date);
            }

            var result = await query.ToListAsync();

            return _mapper.Map<List<Model.Narudzbe>>(result);
        }

        public async Task<Narudzbe> OtkaziNarudzbu(int narudzbaId)
        {
            var set = _dbContext.Set<Database.Narudzbe>();

            var entity = await set.FindAsync(narudzbaId);

            if (entity == null)
            {
                return null;
            }

            entity.Otkazano = true;

            await _dbContext.SaveChangesAsync();
            return _mapper.Map<Model.Narudzbe>(entity);
        }
    }
}
