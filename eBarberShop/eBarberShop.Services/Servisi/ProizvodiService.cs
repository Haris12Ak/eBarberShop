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
    public class ProizvodiService : BaseCRUDService<Model.Proizvodi, Database.Proizvodi, Model.Search.ProizvodiSearch, Model.Requests.ProizvodiInsertRequest, Model.Requests.ProizvodiUpdateRequest>, IProizvodiService
    {
        public ProizvodiService(ApplicationDbContext dbContext, IMapper mapper) : base(dbContext, mapper)
        {
        }

        public override IQueryable<Proizvodi> AddFilter(IQueryable<Proizvodi> query, ProizvodiSearch? search)
        {
            if (!string.IsNullOrWhiteSpace(search?.Naziv))
            {
                query = query.Where(x => x.Naziv.ToLower().StartsWith(search.Naziv.ToLower()));
            }

            if (!string.IsNullOrWhiteSpace(search?.Sifra))
            {
                query = query.Where(x => x.Sifra.ToLower().StartsWith(search.Sifra.ToLower()));
            }

            return base.AddFilter(query, search);
        }
    }
}
