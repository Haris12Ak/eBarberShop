using AutoMapper;
using eBarberShop.Services.Interfejsi;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eBarberShop.Services.Servisi
{
    public class KosaricaService : BaseCRUDService<Model.Kosarica, Database.Kosarica, Model.Search.KosaricaSearch, Model.Requests.KosaricaInsertRequest, Model.Requests.KosaricaUpdateRequest>, IKosaricaService
    {
        public KosaricaService(ApplicationDbContext dbContext, IMapper mapper) : base(dbContext, mapper)
        {
        }
    }
}
