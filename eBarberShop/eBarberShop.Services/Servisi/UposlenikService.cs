using AutoMapper;
using eBarberShop.Model.Search;
using eBarberShop.Services.Database;
using eBarberShop.Services.Interfejsi;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eBarberShop.Services.Servisi
{
    public class UposlenikService : BaseCRUDService<Model.Uposlenik, Database.Uposlenik, Model.Search.UposlenikSearch, Model.Requests.UposlenikInsertRequest, Model.Requests.UposlenikUpdateRequest>, IUposlenikService
    {
        public UposlenikService(ApplicationDbContext dbContext, IMapper mapper) : base(dbContext, mapper)
        {
        }

        public override IQueryable<Uposlenik> AddFilter(IQueryable<Uposlenik> query, UposlenikSearch? search)
        {
            if (!string.IsNullOrWhiteSpace(search?.Ime))
            {
                query = query.Where(x => x.Ime.ToLower().StartsWith(search.Ime.ToLower()));
            }

            if (!string.IsNullOrWhiteSpace(search?.Prezime))
            {
                query = query.Where(x => x.Prezime.ToLower().StartsWith(search.Prezime.ToLower()));
            }

            return base.AddFilter(query, search);
        }
    }
}
