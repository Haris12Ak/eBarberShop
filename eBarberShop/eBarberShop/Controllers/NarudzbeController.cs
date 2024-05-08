using eBarberShop.Model;
using eBarberShop.Model.Requests;
using eBarberShop.Model.Search;
using eBarberShop.Services.Interfejsi;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace eBarberShop.Controllers
{
    [ApiController]
    public class NarudzbeController : BaseCRUDController<Narudzbe, NarudzbeSearch, NarudzbeInsertRequest, NarudzbeUpdateRequest>
    {
        private readonly INarudzbeService _narudzbeService;

        public NarudzbeController(ILogger<BaseCRUDController<Narudzbe, NarudzbeSearch, NarudzbeInsertRequest, NarudzbeUpdateRequest>> logger, INarudzbeService narudzbeService) : base(logger, narudzbeService)
        {
            _narudzbeService = narudzbeService;
        }

        [Authorize(Roles = "Administrator, Uposlenik")]
        [HttpGet("/IzvjestajNarudzbe")]
        public async Task<IzvjestajNarudzbe> GetIzvjestajNarudzbe([FromQuery] IzvjestajNarudzbeSearch? search)
        {
            return await _narudzbeService.GetIzvjestajNarudzbe(search);
        }

        [Authorize(Roles = "Administrator")]
        public override Task<Narudzbe> Delete(int id)
        {
            return base.Delete(id);
        }
    }
}
