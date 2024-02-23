using eBarberShop.Model;
using eBarberShop.Model.Requests;
using eBarberShop.Model.Search;
using eBarberShop.Services.Interfejsi;
using Microsoft.AspNetCore.Mvc;

namespace eBarberShop.Controllers
{
    [ApiController]
    public class RezervacijaUslugeController : BaseCRUDController<RezervacijaUsluge, RezervacijaUslugeSearch, RezervacijaUslugeInsertRequest, RezervacijaUslugeUpdateRequest>
    {
        public RezervacijaUslugeController(ILogger<BaseCRUDController<RezervacijaUsluge, RezervacijaUslugeSearch, RezervacijaUslugeInsertRequest, RezervacijaUslugeUpdateRequest>> logger, IRezervacijaUslugeService service) : base(logger, service)
        {
        }

        [HttpGet("/GetRezervacijeByUslugaId/{uslugaId}")]
        public async Task<List<Model.UslugaRezervacije>> GetRezervacije(int uslugaId, [FromQuery] Model.Search.RezervacijaUslugeSearch? search)
        {
            return await (_service as IRezervacijaUslugeService).GetByUslugaId(uslugaId, search);
        }

    }
}
