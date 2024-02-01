using AutoMapper;
using eBarberShop.Model;
using eBarberShop.Services.Interfejsi;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eBarberShop.Services.Servisi
{
    public class DrzavaService : BaseService<Model.Drzava, Database.Drzava, Model.Search.BaseSearch>, IDrzavaService
    {
        public DrzavaService(ApplicationDbContext dbContext, IMapper mapper) : base(dbContext, mapper)
        {
        }
    }
}
