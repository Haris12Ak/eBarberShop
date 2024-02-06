using AutoMapper;
using eBarberShop.Model.Search;
using eBarberShop.Services.Database;
using eBarberShop.Services.Interfejsi;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eBarberShop.Services.Servisi
{
    public class RezervacijaService : BaseCRUDService<Model.Rezervacija, Database.Rezervacija, Model.Search.RezervacijaSearch, Model.Requests.RezervacijaInsertRequest, Model.Requests.RezervacijaUpdateRequest>, IRezervacijaService
    {
        public RezervacijaService(ApplicationDbContext dbContext, IMapper mapper) : base(dbContext, mapper)
        {
        }

        public override IQueryable<Rezervacija> AddInclude(IQueryable<Rezervacija> query, RezervacijaSearch? search)
        {
            if(search?.IsUslugeIncluded == true)
            {
                query = query.Include("RezervacijaUsluge.Usluga");
            }

            return base.AddInclude(query, search);
        }
    }
}
