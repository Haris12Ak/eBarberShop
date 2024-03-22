using eBarberShop.Model;
using eBarberShop.Model.Requests;
using eBarberShop.Model.Search;

namespace eBarberShop.Services.Interfejsi
{
    public interface IOcjeneService : ICRUDService<Ocjene, OcjeneSearch, OcjeneInsertRequest, OcjeneUpdateRequest>
    {
        Task<List<Ocjene>> GetOcjeneByUposlenikId(int uposlenikId);
    }
}
