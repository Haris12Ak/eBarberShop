using AutoMapper;
using eBarberShop.Model;
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

        public override async Task<PagedResult<Proizvodi>> Get(ProizvodiSearch? search)
        {
            var query = _dbContext.Set<Database.Proizvodi>()
                .Include("VrstaProizvoda")
                .AsQueryable();

            PagedResult<Model.Proizvodi> result = new PagedResult<Model.Proizvodi>();

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

            result.Count = await query.CountAsync();

            if (search?.PageSize.HasValue == true && search?.Page.HasValue == true)
            {
                query = query.Take(search.PageSize.Value).Skip(search.Page.Value * search.PageSize.Value);
            }

            var list = await query.ToListAsync();

            result.Result = _mapper.Map<List<Model.Proizvodi>>(list);

            return result;
        }
    }
}
