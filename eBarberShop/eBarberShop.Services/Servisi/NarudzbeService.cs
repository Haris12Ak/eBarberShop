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
    public class NarudzbeService : BaseCRUDService<Model.Narudzbe, Database.Narudzbe, Model.Search.NarudzbeSearch, Model.Requests.NarudzbeInsertRequest, Model.Requests.NarudzbeUpdateRequest>, INarudzbeService
    {
        public NarudzbeService(ApplicationDbContext dbContext, IMapper mapper) : base(dbContext, mapper)
        {
        }

        public override IQueryable<Narudzbe> AddFilter(IQueryable<Narudzbe> query, NarudzbeSearch? search)
        {
            if (!string.IsNullOrWhiteSpace(search?.BrojNarudzbe))
            {
                query = query.Where(x => x.BrojNarudzbe.StartsWith(search.BrojNarudzbe));
            }

            if(search?.DatumNarudzbe.HasValue == true)
            {
                query = query.Where(x => x.DatumNarudzbe.Date == search.DatumNarudzbe.Value.Date);
            }

            return base.AddFilter(query, search);
        }

        public override IQueryable<Narudzbe> AddInclude(IQueryable<Narudzbe> query, NarudzbeSearch? search)
        {
            if(search?.IsNarudzbeDetaljiInclude == true)
            {
                query = query.Include("NarudzbeDetalji.Proizvod");
            }

            return base.AddInclude(query, search);
        }
    }
}
