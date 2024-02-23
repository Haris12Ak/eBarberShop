using eBarberShop.Model.Search;

namespace eBarberShop.Services.Interfejsi
{
    public interface IRezervacijaUslugeService : ICRUDService<Model.RezervacijaUsluge, RezervacijaUslugeSearch, Model.Requests.RezervacijaUslugeInsertRequest, Model.Requests.RezervacijaUslugeUpdateRequest>
    {
        Task<List<Model.UslugaRezervacije>> GetByUslugaId(int uslugaId, Model.Search.RezervacijaUslugeSearch? search);
    }
}
