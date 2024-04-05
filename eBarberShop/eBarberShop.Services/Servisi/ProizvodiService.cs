using AutoMapper;
using eBarberShop.Model.Search;
using eBarberShop.Services.Interfejsi;
using Microsoft.EntityFrameworkCore;

namespace eBarberShop.Services.Servisi
{
    public class ProizvodiService : BaseCRUDService<Model.Proizvodi, Database.Proizvodi, Model.Search.ProizvodiSearch, Model.Requests.ProizvodiInsertRequest, Model.Requests.ProizvodiUpdateRequest>, IProizvodiService
    {
        public ProizvodiService(ApplicationDbContext dbContext, IMapper mapper) : base(dbContext, mapper)
        {
        }

        public override IQueryable<Database.Proizvodi> AddFilter(IQueryable<Database.Proizvodi> query, ProizvodiSearch? search)
        {
            if (!string.IsNullOrWhiteSpace(search?.Naziv))
            {
                query = query.Where(x => x.Naziv.ToLower().StartsWith(search.Naziv.ToLower()));
            }

            if (!string.IsNullOrWhiteSpace(search?.Sifra))
            {
                query = query.Where(x => x.Sifra.ToLower().StartsWith(search.Sifra.ToLower()));
            }

            if (!string.IsNullOrWhiteSpace(search?.VrstaProizvoda))
            {
                query = query.Where(x => x.VrstaProizvoda.Naziv.ToLower().StartsWith(search.VrstaProizvoda.ToLower()));
            }

            return base.AddFilter(query, search);
        }

        public override IQueryable<Database.Proizvodi> AddInclude(IQueryable<Database.Proizvodi> query, ProizvodiSearch? search)
        {
            if (search?.IsVrsteProizvodaIncluded == true)
            {
                query = query.Include("VrstaProizvoda");

            }
            return base.AddInclude(query, search);
        }
    }
}
