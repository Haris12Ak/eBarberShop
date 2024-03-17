using AutoMapper;
using eBarberShop.Model;
using eBarberShop.Model.Search;
using eBarberShop.Services.Interfejsi;
using Microsoft.EntityFrameworkCore;

namespace eBarberShop.Services.Servisi
{
    public class NovostiService : BaseCRUDService<Model.Novosti, Database.Novosti, Model.Search.NovostiSearch, Model.Requests.NovostiInsertRequest, Model.Requests.NovostiUpdateRequest>, INovostiService
    {
        public NovostiService(ApplicationDbContext dbContext, IMapper mapper) : base(dbContext, mapper)
        {
        }

        public override IQueryable<Database.Novosti> AddFilter(IQueryable<Database.Novosti> query, NovostiSearch? search)
        {
            if (search?.DatumObjave.HasValue == true)
            {
                query = query.Where(x => x.DatumObjave.Date == search.DatumObjave.Value.Date);
            }

            if (!string.IsNullOrWhiteSpace(search?.Naslov))
            {
                query = query.Where(x => x.Naslov.ToLower().Contains(search.Naslov.ToLower()));
            }

            return base.AddFilter(query, search);
        }

        public override IQueryable<Database.Novosti> AddInclude(IQueryable<Database.Novosti> query, NovostiSearch? search)
        {
            if (search?.IsKorisnikInclude == true)
            {
                query = query.Include("Korisnik");
            }

            return base.AddInclude(query, search);
        }

        public override async Task<Novosti> GetById(int id)
        {
            var data = await _dbContext.Set<Database.Novosti>().Include("Korisnik").Where(x => x.NovostiId == id).FirstOrDefaultAsync();

            if (data == null)
                return null;

            return _mapper.Map<Model.Novosti>(data);
        }
    }
}
