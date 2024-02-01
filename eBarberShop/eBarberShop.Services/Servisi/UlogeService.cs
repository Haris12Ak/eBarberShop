using AutoMapper;
using eBarberShop.Services.Interfejsi;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eBarberShop.Services.Servisi
{
    public class UlogeService : BaseService<Model.Uloge, Database.Uloge, Model.Search.BaseSearch>, IUlogeService
    {
        public UlogeService(ApplicationDbContext dbContext, IMapper mapper) : base(dbContext, mapper)
        {
        }
    }
}
