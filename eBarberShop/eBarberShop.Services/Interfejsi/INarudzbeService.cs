using eBarberShop.Model;
using eBarberShop.Model.Requests;
using eBarberShop.Model.Search;

namespace eBarberShop.Services.Interfejsi
{
    public interface INarudzbeService : ICRUDService<Narudzbe, NarudzbeSearch, NarudzbeInsertRequest, NarudzbeUpdateRequest>
    {
        Task<IzvjestajNarudzbe> GetIzvjestajNarudzbe(IzvjestajNarudzbeSearch? search);
        Task<List<Narudzbe>> GetNarudzbeByKorisnikId(int korisnikId, DateTime? datumNarudzbe);
        Task<Narudzbe> OtkaziNarudzbu(int narudzbaId);
    }
}
