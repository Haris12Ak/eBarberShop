using AutoMapper;
using eBarberShop.Model;
using eBarberShop.Model.Requests;
using eBarberShop.Model.Search;
using eBarberShop.Services.Interfejsi;
using Microsoft.EntityFrameworkCore;

namespace eBarberShop.Services.Servisi
{
    public class OcjeneService : BaseCRUDService<Model.Ocjene, Database.Ocjene, Model.Search.OcjeneSearch, Model.Requests.OcjeneInsertRequest, Model.Requests.OcjeneUpdateRequest>, IOcjeneService
    {
        public OcjeneService(ApplicationDbContext dbContext, IMapper mapper) : base(dbContext, mapper)
        {
        }

        public override IQueryable<Database.Ocjene> AddInclude(IQueryable<Database.Ocjene> query, OcjeneSearch? search)
        {
            if (search?.IsKorisnikInclude == true)
            {
                query = query.Include("Korisnik");
            }

            return base.AddInclude(query, search);
        }

        public async Task<List<Ocjene>> GetOcjeneByUposlenikId(int uposlenikId)
        {
            var data = await _dbContext.Set<Database.Ocjene>()
                .Include("Uposlenik")
                .Include("Korisnik")
                .Where(x => x.UposlenikId == uposlenikId).ToListAsync();

            return _mapper.Map<List<Model.Ocjene>>(data);
        }

        public async override Task<Ocjene> Insert(OcjeneInsertRequest insert)
        {
            var set = _dbContext.Set<Database.Ocjene>();

            var ocjene = await set.ToListAsync();

            if (ocjene.Count > 0)
            {
                foreach (var item in ocjene)
                {
                    if (item.KorisnikId == insert.KorisnikId && item.UposlenikId == insert.UposlenikId)
                    {
                        throw new UserException("Nije moguce dodati ocjenu! Dodavanje ocjene uposlenika je dozvoljeno samo jednom.");
                    }
                }
            }

            var entity = _mapper.Map<Database.Ocjene>(insert);

            await set.AddAsync(entity);

            await _dbContext.SaveChangesAsync();

            return _mapper.Map<Model.Ocjene>(entity);
        }
    }
}
