using eBarberShop.Model;
using eBarberShop.Services.Interfejsi;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eBarberShop.Controllers
{
    [ApiController]
    public class UlogeController : BaseController<Model.Uloge>
    {
        public UlogeController(ILogger<BaseController<Uloge>> logger, IUlogeService service) : base(logger, service)
        {
        }
    }
}
