using eBarberShop.Model;
using eBarberShop.Model.Search;
using eBarberShop.Services.Interfejsi;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eBarberShop.Controllers
{
    [ApiController]
    public class UlogeController : BaseController<Uloge, BaseSearch>
    {
        public UlogeController(ILogger<BaseController<Uloge, BaseSearch>> logger, IUlogeService service) : base(logger, service)
        {
        }
    }
}
