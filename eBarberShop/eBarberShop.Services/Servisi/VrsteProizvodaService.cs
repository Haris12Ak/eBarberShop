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
    public class VrsteProizvodaService : BaseCRUDService<Model.VrsteProizvoda, Database.VrsteProizvoda, Model.Search.VrsteProizvodaSearch, Model.Requests.VrsteProizvodaInsertRequest, Model.Requests.VrsteProizvodaUpdateRequest>, IVrsteProizvodaService
    {
        public VrsteProizvodaService(ApplicationDbContext dbContext, IMapper mapper) : base(dbContext, mapper)
        {
        }

        public override IQueryable<VrsteProizvoda> AddFilter(IQueryable<VrsteProizvoda> query, VrsteProizvodaSearch? search)
        {
            if (!string.IsNullOrWhiteSpace(search?.Naziv))
            {
                query = query.Where(x => x.Naziv.ToLower().StartsWith(search.Naziv.ToLower()));
            }

            return base.AddFilter(query, search);
        }
    }
}
