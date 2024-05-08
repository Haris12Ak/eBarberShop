using eBarberShop.Model;
using eBarberShop.Model.Requests;
using eBarberShop.Model.Search;
using eBarberShop.Services.Interfejsi;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace eBarberShop.Controllers
{
    [ApiController]
    public class SlikeUslugeController : BaseCRUDController<Model.SlikeUsluge, Model.Search.BaseSearch, Model.Requests.SlikeUslugeInsertRequest, Model.Requests.SlikeUslugeUpdateRequest>
    {
        private readonly ISlikeUslugeService _slikeUslugeService;

        public SlikeUslugeController(ILogger<BaseCRUDController<SlikeUsluge, BaseSearch, SlikeUslugeInsertRequest, SlikeUslugeUpdateRequest>> logger, ISlikeUslugeService slikeUslugeService) : base(logger, slikeUslugeService)
        {
            _slikeUslugeService = slikeUslugeService;
        }

        [HttpGet("/GetSlikeByUslugaId/{uslugaId}")]
        public async Task<List<Model.SlikeUsluge>> GetSlike(int uslugaId, [FromQuery] Model.Search.BaseSearch? search)
        {
            return await _slikeUslugeService.GetByUslugaId(uslugaId, search);
        }

        [Authorize(Roles = "Administrator")]
        public override Task<SlikeUsluge> Insert([FromBody] SlikeUslugeInsertRequest insert)
        {
            return base.Insert(insert);
        }

        [Authorize(Roles = "Administrator")]
        public override Task<SlikeUsluge> Update(int id, [FromBody] SlikeUslugeUpdateRequest update)
        {
            return base.Update(id, update);
        }

        [Authorize(Roles = "Administrator")]
        public override Task<SlikeUsluge> Delete(int id)
        {
            return base.Delete(id);
        }
    }
}
