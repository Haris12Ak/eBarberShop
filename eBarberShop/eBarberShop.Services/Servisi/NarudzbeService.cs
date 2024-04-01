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
        public NarudzbeService(ApplicationDbContext dbContext, IMapper mapper, IKorisniciService korisniciService) : base(dbContext, mapper)
        {
            _korisniciService = korisniciService;
        }

        public override async Task<Model.PagedResult<Model.Narudzbe>> Get(NarudzbeSearch? search)
        {
            var query = _dbContext.Set<Database.Narudzbe>()
                .Include("Korisnik.Grad")
                .AsQueryable();

            PagedResult<Model.Narudzbe> result = new PagedResult<Model.Narudzbe>();

            if (!string.IsNullOrWhiteSpace(search?.BrojNarudzbe))
            {
                query = query.Where(x => x.BrojNarudzbe.Contains(search.BrojNarudzbe));
            }

            if (search?.DatumNarudzbe.HasValue == true)
            {
                query = query.Where(x => x.DatumNarudzbe.Date == search.DatumNarudzbe.Value.Date);
            }

            result.Count = await query.CountAsync();

            if (search?.PageSize.HasValue == true && search?.Page.HasValue == true)
            {
                query = query.Take(search.PageSize.Value).Skip(search.Page.Value * search.PageSize.Value);
            }

            var list = await query.ToListAsync();

            result.Result = _mapper.Map<List<Model.Narudzbe>>(list);

            return result;
        }


        public override IQueryable<Database.Narudzbe> AddInclude(IQueryable<Database.Narudzbe> query, NarudzbeSearch? search)
        {
            if (search?.IsNarudzbeDetaljiInclude == true)
            {
                query = query.Include("NarudzbeDetalji.Proizvod");
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


    }
}
