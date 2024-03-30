using eBarberShop.Model;
using eBarberShop.Model.Search;
using eBarberShop.Services.Interfejsi;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace eBarberShop.Controllers
{
    [ApiController]
    public class GradController : BaseController<Model.Grad, BaseSearch>
    {
        public GradController(ILogger<BaseController<Grad, BaseSearch>> logger, IGradService service) : base(logger, service)
        {
        }


        [AllowAnonymous]
        [HttpGet]
        public override Task<PagedResult<Grad>> Get([FromQuery] BaseSearch? search)
        {
            return base.Get(search);
        }
    }
}
