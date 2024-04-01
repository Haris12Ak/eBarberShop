namespace eBarberShop.Services.Interfejsi
{
    public interface INarudzbeDetaljiService : ICRUDService<Model.NarudzbeDetalji, Model.Search.BaseSearch, Model.Requests.NarudzbeDetaljiInsertRequest, Model.Requests.NarudzbeDetaljiUpdateRequest>
    {
        Task<List<Model.NarudzbeDetalji>> GetNarudzbeDetaljiByNarudzbaId(int narudzbaId);
    }
}
