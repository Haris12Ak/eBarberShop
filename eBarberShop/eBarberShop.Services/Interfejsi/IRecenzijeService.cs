using eBarberShop.Model;
using eBarberShop.Model.Requests;
using eBarberShop.Model.Search;

namespace eBarberShop.Services.Interfejsi
{
    public interface IRecenzijeService : ICRUDService<Recenzije, RecenzijeSearch, RecenzijeInsertRequest, RecenzijeUpdateRequest>
    {
        Task<List<Recenzije>> GetRecenzijeByKorisnikId(int korisnikId);
    }
}
