using eBarberShop.Model;
using eBarberShop.Model.Requests;
using eBarberShop.Model.Search;
using eBarberShop.Services.Interfejsi;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eBarberShop.Controllers
{
    [ApiController]
    public class DrzavaController : BaseController<Drzava, BaseSearch>
    {
        public DrzavaController(ILogger<BaseController<Drzava, BaseSearch>> logger, IDrzavaService service) : base(logger, service)
        {
        }
    }
}
