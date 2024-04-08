using AutoMapper;
using eBarberShop.Model.Search;
using eBarberShop.Services.Database;
using eBarberShop.Services.Interfejsi;

namespace eBarberShop.Services.Servisi
{
    public class SlikeService : BaseCRUDService<Model.Slike, Database.Slike, Model.Search.SlikeSearch, Model.Requests.SlikeInsertRequest, Model.Requests.SlikeUpdateRequest>, ISlikeService
    {
        public SlikeService(ApplicationDbContext dbContext, IMapper mapper) : base(dbContext, mapper)
        {
        }

        public override IQueryable<Slike> AddFilter(IQueryable<Slike> query, SlikeSearch? search)
        {
            if (search?.DatumObjave.HasValue == true)
            {
                query = query.Where(x => x.DatumPostavljanja.Date == search.DatumObjave.Value.Date);
            }

            return base.AddFilter(query, search);
        }
    }
}
