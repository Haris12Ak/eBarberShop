using eBarberShop.Model;
using eBarberShop.Model.Requests;
using eBarberShop.Model.Search;
using eBarberShop.Services.Interfejsi;
using Microsoft.AspNetCore.Mvc;

namespace eBarberShop.Controllers
{
    [ApiController]
    public class KorisniciController : BaseCRUDController<Korisnici, KorisniciSearch, KorisniciInsertRequest, KorisniciUpdateRequest>
    {
        public KorisniciController(ILogger<BaseCRUDController<Korisnici, KorisniciSearch, KorisniciInsertRequest, KorisniciUpdateRequest>> logger, IKorisniciService service) : base(logger, service)
        {
        }
    }
}
