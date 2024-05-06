using eBarberShop.Model;
using eBarberShop.Model.Requests;
using eBarberShop.Model.Search;
using eBarberShop.Services.Interfejsi;
using Microsoft.AspNetCore.Mvc;

namespace eBarberShop.Controllers
{
    [ApiController]
    public class PaymentDetailController : BaseCRUDController<PaymentDetail, BaseSearch, PaymentDetailInsertRequest, PaymentDetailUpdateRequest>
    {
        private readonly IPaymentDetailService _paymentDetailService;

        public PaymentDetailController(ILogger<BaseCRUDController<PaymentDetail, BaseSearch, PaymentDetailInsertRequest, PaymentDetailUpdateRequest>> logger, IPaymentDetailService service) : base(logger, service)
        {
            _paymentDetailService = service;
        }

        [HttpGet("/GetByNarudzbaId/{narudzbaId}")]
        public async Task<Model.PaymentDetail> GetByNarudzbaId(int narudzbaId)
        {
            return await _paymentDetailService.GetByNarudzbaId(narudzbaId);
        }
    }
}
