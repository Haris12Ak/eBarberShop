using AutoMapper;
using eBarberShop.Services.Interfejsi;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eBarberShop.Services.Servisi
{
    public class SlikeService : BaseCRUDService<Model.Slike, Database.Slike, Model.Search.SlikeSearch, Model.Requests.SlikeInsertRequest, Model.Requests.SlikeUpdateRequest>, ISlikeService
    {
        public SlikeService(ApplicationDbContext dbContext, IMapper mapper) : base(dbContext, mapper)
        {
        }
    }
}
