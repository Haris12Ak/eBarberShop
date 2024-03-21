namespace eBarberShop.Services.Interfejsi
{
    public interface ISlikeUslugeService : ICRUDService<Model.SlikeUsluge, Model.Search.BaseSearch, Model.Requests.SlikeUslugeInsertRequest, Model.Requests.SlikeUslugeUpdateRequest>
    {
        Task<List<Model.SlikeUsluge>> GetByUslugaId(int uslugaId, Model.Search.BaseSearch? search);
    }
}
