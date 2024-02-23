using AutoMapper;
using eBarberShop.Services.Interfejsi;
using Microsoft.EntityFrameworkCore;

namespace eBarberShop.Services.Servisi
{
    public class RezervacijaUslugeService : BaseCRUDService<Model.RezervacijaUsluge, Database.RezervacijaUsluge, Model.Search.RezervacijaUslugeSearch, Model.Requests.RezervacijaUslugeInsertRequest, Model.Requests.RezervacijaUslugeUpdateRequest>, IRezervacijaUslugeService
    {
        public RezervacijaUslugeService(ApplicationDbContext dbContext, IMapper mapper) : base(dbContext, mapper)
        {
        }

        public async Task<List<Model.UslugaRezervacije>> GetByUslugaId(int uslugaId, Model.Search.RezervacijaUslugeSearch? search)
        {
            var query = _dbContext.Set<Database.RezervacijaUsluge>().Include("Rezervacija.Korisnik").Where(x => x.UslugaId == uslugaId).AsQueryable();

            if (search?.DatumTermina.HasValue == true)
            {
                query = query.Where(x => x.Rezervacija.Datum.Date == search.DatumTermina.Value.Date);
            }

            var data = await query.ToListAsync();

            return _mapper.Map<List<Model.UslugaRezervacije>>(data);
        }
    }
}
