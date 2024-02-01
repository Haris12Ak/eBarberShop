using eBarberShop.Model;
using eBarberShop.Model.Requests;
using eBarberShop.Services.Interfejsi;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eBarberShop.Controllers
{
    [ApiController]
    public class DrzavaController : BaseController<Drzava>
    {
        public DrzavaController(ILogger<BaseController<Drzava>> logger, IDrzavaService service) : base(logger, service)
        {
        }
    }
}
