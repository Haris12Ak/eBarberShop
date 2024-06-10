using eBarberShop.Model;
using eBarberShop.Model.Requests;
using eBarberShop.Model.Search;
using eBarberShop.Services.Interfejsi;
using Microsoft.AspNetCore.Mvc;

namespace eBarberShop.Controllers
{
    [ApiController]
    public class NarudzbeDetaljiController : BaseCRUDController<NarudzbeDetalji, BaseSearch, NarudzbeDetaljiInsertRequest, NarudzbeDetaljiUpdateRequest>
    {
        private readonly INarudzbeDetaljiService _narudzbeDetaljiService;
        public NarudzbeDetaljiController(ILogger<BaseCRUDController<NarudzbeDetalji, BaseSearch, NarudzbeDetaljiInsertRequest, NarudzbeDetaljiUpdateRequest>> logger, INarudzbeDetaljiService narudzbeDetaljiService) : base(logger, narudzbeDetaljiService)
        {
            _narudzbeDetaljiService = narudzbeDetaljiService;
        }

        [HttpGet("/GetNarudzbeDetaljiByNarudzbaId/{narudzbaId}")]
        public async Task<List<NarudzbeDetalji>> GetNarudzbeDetalji(int narudzbaId)
        {
            return await _narudzbeDetaljiService.GetNarudzbeDetaljiByNarudzbaId(narudzbaId);
        }
    }
}
