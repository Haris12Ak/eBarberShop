using AutoMapper;
using eBarberShop.Services.Interfejsi;
using Microsoft.EntityFrameworkCore;

namespace eBarberShop.Services.Servisi
{
    public class SlikeUslugeService : BaseCRUDService<Model.SlikeUsluge, Database.SlikeUsluge, Model.Search.BaseSearch, Model.Requests.SlikeUslugeInsertRequest, Model.Requests.SlikeUslugeUpdateRequest>, ISlikeUslugeService
    {
        public SlikeUslugeService(ApplicationDbContext dbContext, IMapper mapper) : base(dbContext, mapper)
        {
        }

        public async Task<List<Model.SlikeUsluge>> GetByUslugaId(int uslugaId, Model.Search.BaseSearch? search)
        {
            var query = _dbContext.Set<Database.SlikeUsluge>().Include("Slika").Where(x => x.UslugaId == uslugaId).AsQueryable();

            var data = await query.ToListAsync();

            return _mapper.Map<List<Model.SlikeUsluge>>(data);
        }
    }
}
