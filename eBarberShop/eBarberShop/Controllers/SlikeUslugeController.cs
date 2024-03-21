using eBarberShop.Model;
using eBarberShop.Model.Requests;
using eBarberShop.Model.Search;
using eBarberShop.Services.Interfejsi;
using Microsoft.AspNetCore.Mvc;

namespace eBarberShop.Controllers
{
    [ApiController]
    public class SlikeUslugeController : BaseCRUDController<Model.SlikeUsluge, Model.Search.BaseSearch, Model.Requests.SlikeUslugeInsertRequest, Model.Requests.SlikeUslugeUpdateRequest>
    {
        public SlikeUslugeController(ILogger<BaseCRUDController<SlikeUsluge, BaseSearch, SlikeUslugeInsertRequest, SlikeUslugeUpdateRequest>> logger, ISlikeUslugeService service) : base(logger, service)
        {
        }

        [HttpGet("/GetSlikeByUslugaId/{uslugaId}")]
        public async Task<List<Model.SlikeUsluge>> GetSlike(int uslugaId, [FromQuery] Model.Search.BaseSearch? search)
        {
            return await (_service as ISlikeUslugeService).GetByUslugaId(uslugaId, search);
        }
    }
}
