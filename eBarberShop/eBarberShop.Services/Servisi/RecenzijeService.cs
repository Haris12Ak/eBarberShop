using AutoMapper;
using eBarberShop.Model;
using eBarberShop.Model.Search;
using eBarberShop.Services.Interfejsi;
using Microsoft.EntityFrameworkCore;

namespace eBarberShop.Services.Servisi
{
    public class RecenzijeService : BaseCRUDService<Model.Recenzije, Database.Recenzije, Model.Search.RecenzijeSearch, Model.Requests.RecenzijeInsertRequest, Model.Requests.RecenzijeUpdateRequest>, IRecenzijeService
    {
        public RecenzijeService(ApplicationDbContext dbContext, IMapper mapper) : base(dbContext, mapper)
        {
        }

        public override async Task<Model.PagedResult<Model.Recenzije>> Get(RecenzijeSearch? search)
        {
            var query = _dbContext.Set<Database.Recenzije>()
                .Include("Korisnik")
                .AsQueryable();

            PagedResult<Model.Recenzije> result = new PagedResult<Model.Recenzije>();

            if (search?.DatumObjave.HasValue == true)
            {
                query = query.Where(x => x.DatumObjave.Date == search.DatumObjave.Value.Date);
            }

            result.Count = await query.CountAsync();

            if (search?.PageSize.HasValue == true && search?.Page.HasValue == true)
            {
                query = query.Take(search.PageSize.Value).Skip(search.Page.Value * search.PageSize.Value);
            }

            var list = await query.ToListAsync();

            result.Result = _mapper.Map<List<Model.Recenzije>>(list);

            return result;
        }

        public override IQueryable<Database.Recenzije> AddFilter(IQueryable<Database.Recenzije> query, RecenzijeSearch? search)
        {
            if (search?.DatumObjave.HasValue == true)
            {
                query = query.Where(x => x.DatumObjave.Date == search.DatumObjave.Value.Date);
            }

            return base.AddFilter(query, search);
        }
    }
}
