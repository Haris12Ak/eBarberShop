using AutoMapper;
using eBarberShop.Model.Search;
using eBarberShop.Services.Database;
using eBarberShop.Services.Interfejsi;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eBarberShop.Services.Servisi
{
    public class UslugaService : BaseCRUDService<Model.Usluga, Database.Usluga, Model.Search.UslugaSearch, Model.Requests.UslugaInsertRequest, Model.Requests.UslugaUpdateRequest>, IUslugaService
    {
        public UslugaService(ApplicationDbContext dbContext, IMapper mapper) : base(dbContext, mapper)
        {
        }

        public override IQueryable<Usluga> AddFilter(IQueryable<Usluga> query, UslugaSearch? search)
        {
            if (!string.IsNullOrWhiteSpace(search?.Naziv))
            {
                query = query.Where(x => x.Naziv.ToLower().Contains(search.Naziv.ToLower()));
            }

            return base.AddFilter(query, search);
        }
    }
}
