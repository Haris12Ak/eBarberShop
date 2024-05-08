using eBarberShop.Model;
using eBarberShop.Model.Search;
using eBarberShop.Services.Interfejsi;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace eBarberShop.Controllers
{
    [ApiController]
    public class UlogeController : BaseController<Uloge, BaseSearch>
    {
        public UlogeController(ILogger<BaseController<Uloge, BaseSearch>> logger, IUlogeService service) : base(logger, service)
        {
        }

        [Authorize(Roles = "Administrator")]
        public override Task<PagedResult<Uloge>> Get([FromQuery] BaseSearch? search)
        {
            return base.Get(search);
        }

        [Authorize(Roles = "Administrator")]
        public override Task<Uloge> GetById(int id)
        {
            return base.GetById(id);
        }
    }
}
