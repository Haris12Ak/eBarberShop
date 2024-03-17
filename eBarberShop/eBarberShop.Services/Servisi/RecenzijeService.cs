using AutoMapper;
using eBarberShop.Model;
using eBarberShop.Model.Requests;
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

        public override async Task<Recenzije> Insert(RecenzijeInsertRequest insert)
        {
            var set = _dbContext.Set<Database.Recenzije>();

            var recenzije = await set.ToListAsync();

            if (recenzije.Count > 0)
            {
                foreach (var item in recenzije)
                {
                    if (item.KorisnikId == insert.KorisnikId)
                    {
                        throw new UserException("Nije moguce dodati recenziju! Dodavanje recenzije je dozvoljeno samo jednom.");
                    }
                }
            }

            var entity = _mapper.Map<Database.Recenzije>(insert);

            await set.AddAsync(entity);

            await _dbContext.SaveChangesAsync();

            return _mapper.Map<Model.Recenzije>(entity);
        }
    }
}
