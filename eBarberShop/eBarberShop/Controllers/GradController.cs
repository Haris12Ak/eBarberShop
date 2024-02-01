using eBarberShop.Model;
using eBarberShop.Model.Search;
using eBarberShop.Services.Interfejsi;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eBarberShop.Controllers
{
    [ApiController]
    public class GradController : BaseController<Model.Grad, BaseSearch>
    {
        public GradController(ILogger<BaseController<Grad, BaseSearch>> logger, IGradService service) : base(logger, service)
        {
        }
    }
}
