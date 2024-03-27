using eBarberShop.Model;
using eBarberShop.Model.Requests;
using eBarberShop.Model.Search;

namespace eBarberShop.Services.Interfejsi
{
    public interface IRezervacijaService : ICRUDService<Rezervacija, RezervacijaSearch, RezervacijaInsertRequest, RezervacijaUpdateRequest>
    {
        Task<List<Model.Termini>> GetTermine(TerminiSearch? search);
        Task<Model.Rezervacija> RezervisiTermin(int uslugaId, RezervacijaInsertRequest request);
        Task<List<Model.TerminiKorisnikaInfo>> GetTermineByKorisnikId(int korisnikId);
    }
}
