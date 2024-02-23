using AutoMapper;
using eBarberShop.Model.Search;
using eBarberShop.Services.Database;
using eBarberShop.Services.Interfejsi;
using Microsoft.EntityFrameworkCore;

namespace eBarberShop.Services.Servisi
{
    public class RezervacijaService : BaseCRUDService<Model.Rezervacija, Database.Rezervacija, Model.Search.RezervacijaSearch, Model.Requests.RezervacijaInsertRequest, Model.Requests.RezervacijaUpdateRequest>, IRezervacijaService
    {
        public RezervacijaService(ApplicationDbContext dbContext, IMapper mapper) : base(dbContext, mapper)
        {
        }

        public override IQueryable<Rezervacija> AddInclude(IQueryable<Rezervacija> query, RezervacijaSearch? search)
        {
            if (search?.IsUslugeIncluded == true)
            {
                query = query.Include("RezervacijaUsluge.Usluga");
            }

            return base.AddInclude(query, search);
        }

        public override async Task<Model.Rezervacija> Delete(int id)
        {
            var rezervacija = await _dbContext.Set<Database.Rezervacija>().FindAsync(id);

            if (rezervacija == null)
                return null;

            _dbContext.RezervacijaUsluge.RemoveRange(rezervacija.RezervacijaUsluge);

            _dbContext.Rezervacija.Remove(rezervacija);
            await _dbContext.SaveChangesAsync();

            return _mapper.Map<Model.Rezervacija>(rezervacija);
        }
    }
}
