using AutoMapper;
using eBarberShop.Services.Interfejsi;
using Microsoft.EntityFrameworkCore;

namespace eBarberShop.Services.Servisi
{
    public class NarudzbeDetaljiService : BaseCRUDService<Model.NarudzbeDetalji, Database.NarudzbeDetalji, Model.Search.BaseSearch, Model.Requests.NarudzbeDetaljiInsertRequest, Model.Requests.NarudzbeDetaljiUpdateRequest>, INarudzbeDetaljiService
    {
        public NarudzbeDetaljiService(ApplicationDbContext dbContext, IMapper mapper) : base(dbContext, mapper)
        {
        }

        public async Task<List<Model.NarudzbeDetalji>> GetNarudzbeDetaljiByNarudzbaId(int narudzbaId)
        {
            var query = _dbContext.Set<Database.NarudzbeDetalji>().Include("Proizvod").Where(x => x.NarudzbaId == narudzbaId).AsQueryable();

            var data = await query.ToListAsync();

            return _mapper.Map<List<Model.NarudzbeDetalji>>(data);
        }
    }
}
