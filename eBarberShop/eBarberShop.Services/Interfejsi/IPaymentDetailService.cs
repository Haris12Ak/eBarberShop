namespace eBarberShop.Services.Interfejsi
{
    public interface IPaymentDetailService : ICRUDService<Model.PaymentDetail, Model.Search.BaseSearch, Model.Requests.PaymentDetailInsertRequest, Model.Requests.PaymentDetailUpdateRequest>
    {
        Task<Model.PaymentDetail> GetByNarudzbaId(int narudzbaId);
    }
}
