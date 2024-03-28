using AutoMapper;
using eBarberShop.Services.Interfejsi;

namespace eBarberShop.Services.Servisi
{
    public class NarudzbeDetaljiService : BaseCRUDService<Model.NarudzbeDetalji, Database.NarudzbeDetalji, Model.Search.BaseSearch, Model.Requests.NarudzbeDetaljiInsertRequest, Model.Requests.NarudzbeDetaljiUpdateRequest>, INarudzbeDetaljiService
    {
        public NarudzbeDetaljiService(ApplicationDbContext dbContext, IMapper mapper) : base(dbContext, mapper)
        {
        }
    }
}
