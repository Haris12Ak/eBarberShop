using AutoMapper;
using eBarberShop.Model.Search;
using eBarberShop.Services.Interfejsi;
using Microsoft.EntityFrameworkCore;

namespace eBarberShop.Services.Servisi
{
    public class RecenzijeService : BaseCRUDService<Model.Recenzije, Database.Recenzije, Model.Search.RecenzijeSearch, Model.Requests.RecenzijeInsertRequest, Model.Requests.RecenzijeUpdateRequest>, IRecenzijeService
    {
        public RecenzijeService(ApplicationDbContext dbContext, IMapper mapper) : base(dbContext, mapper)
        {
        }

        public override IQueryable<Database.Recenzije> AddInclude(IQueryable<Database.Recenzije> query, RecenzijeSearch? search)
        {
            if (search?.isKorisnikInclude == true)
            {
                query = query.Include("Korisnik");
            }
            return base.AddInclude(query, search);
        }

        public override IQueryable<Database.Recenzije> AddFilter(IQueryable<Database.Recenzije> query, RecenzijeSearch? search)
        {
            if (search?.DatumObjave.HasValue == true)
            {
                query = query.Where(x => x.DatumObjave.Date == search.DatumObjave.Value.Date);
            }

            return base.AddFilter(query, search);
        }

        public async Task<List<Model.Recenzije>> GetRecenzijeByKorisnikId(int korisnikId)
        {
            var data = await _dbContext.Set<Database.Recenzije>().Include("Korisnik").Where(x => x.KorisnikId == korisnikId).ToListAsync();

            return _mapper.Map<List<Model.Recenzije>>(data);
        }
    }
}
