using eBarberShop.Model;
using eBarberShop.Model.Requests;
using eBarberShop.Model.Search;
using eBarberShop.Services.Interfejsi;
using Microsoft.AspNetCore.Mvc;

namespace eBarberShop.Controllers
{
    [ApiController]
    public class NarudzbeController : BaseCRUDController<Narudzbe, NarudzbeSearch, NarudzbeInsertRequest, NarudzbeUpdateRequest>
    {
        public NarudzbeController(ILogger<BaseCRUDController<Narudzbe, NarudzbeSearch, NarudzbeInsertRequest, NarudzbeUpdateRequest>> logger, INarudzbeService service) : base(logger, service)
        {
        }

        [HttpGet("/IzvjestajNarudzbe")]
        public async Task<IzvjestajNarudzbe> GetIzvjestajNarudzbe([FromQuery] IzvjestajNarudzbeSearch? search)
        {
            return await (_service as INarudzbeService).GetIzvjestajNarudzbe(search);
        }
    }
}
