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

        public override async Task<Model.PagedResult<Model.Novosti>> Get(NovostiSearch? search)
        {
            var query = _dbContext.Set<Database.Novosti>().Include("Korisnik").AsQueryable();

            PagedResult<Model.Novosti> result = new PagedResult<Model.Novosti>();

            if (search?.DatumObjave.HasValue == true)
            {
                query = query.Where(x => x.DatumObjave.Date == search.DatumObjave.Value.Date);
            }

            if (!string.IsNullOrWhiteSpace(search?.Naslov))
            {
                query = query.Where(x => x.Naslov.ToLower().Contains(search.Naslov.ToLower()));
            }

            result.Count = await query.CountAsync();

            if (search?.PageSize.HasValue == true && search?.Page.HasValue == true)
            {
                query = query.Take(search.PageSize.Value).Skip(search.Page.Value * search.PageSize.Value);
            }

            var list = await query.ToListAsync();

            result.Result = _mapper.Map<List<Model.Novosti>>(list);

            return result;
        }
    }
}
