using AutoMapper;
using eBarberShop.Model;
using eBarberShop.Model.Search;
using eBarberShop.Services.Interfejsi;
using Microsoft.EntityFrameworkCore;

namespace eBarberShop.Services.Servisi
{
    public class UposlenikService : BaseCRUDService<Model.Uposlenik, Database.Uposlenik, Model.Search.UposlenikSearch, Model.Requests.UposlenikInsertRequest, Model.Requests.UposlenikUpdateRequest>, IUposlenikService
    {
        public UposlenikService(ApplicationDbContext dbContext, IMapper mapper) : base(dbContext, mapper)
        {
        }

        public async override Task<PagedResult<Model.Uposlenik>> Get(UposlenikSearch? search)
        {
            var query = _dbContext.Set<Database.Uposlenik>().Include("Ocjene")
                .Select(x => new Model.Uposlenik()
                {
                    UposlenikId = x.UposlenikId,
                    Ime = x.Ime,
                    Prezime = x.Prezime,
                    KontaktTelefon = x.KontaktTelefon,
                    Email = x.Email,
                    Adresa = x.Adresa,
                    ProsjecnaOcjena = x.Ocjene.Any() ? x.Ocjene.Average(y => y.Ocjena) : 0
                }).AsQueryable();

            PagedResult<Model.Uposlenik> result = new PagedResult<Model.Uposlenik>();

            if (!string.IsNullOrWhiteSpace(search?.Ime))
            {
                query = query.Where(x => x.Ime.ToLower().StartsWith(search.Ime.ToLower()));
            }

            if (!string.IsNullOrWhiteSpace(search?.Prezime))
            {
                query = query.Where(x => x.Prezime.ToLower().StartsWith(search.Prezime.ToLower()));
            }

            result.Count = query.Count();

            if (search?.PageSize.HasValue == true && search?.Page.HasValue == true)
            {
                query = query.Take(search.PageSize.Value).Skip(search.Page.Value * search.PageSize.Value);
            }

            var list = await query.ToListAsync();

            result.Result = _mapper.Map<List<Model.Uposlenik>>(list);

            return result;
        }
    }
}
