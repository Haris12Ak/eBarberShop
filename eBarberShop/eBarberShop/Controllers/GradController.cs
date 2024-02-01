using eBarberShop.Model;
using eBarberShop.Services.Interfejsi;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eBarberShop.Controllers
{
    [ApiController]
    public class GradController : BaseController<Model.Grad>
    {
        public GradController(ILogger<BaseController<Grad>> logger, IGradService service) : base(logger, service)
        {
        }
    }
}
