using AutoMapper;
using eBarberShop.Services.Interfejsi;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eBarberShop.Services.Servisi
{
    public class GradService : BaseService<Model.Grad, Database.Grad>, IGradService
    {
        public GradService(ApplicationDbContext dbContext, IMapper mapper) : base(dbContext, mapper)
        {
        }
    }
}
