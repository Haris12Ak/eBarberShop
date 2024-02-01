using eBarberShop.Model;
using eBarberShop.Model.Requests;
using eBarberShop.Services.Interfejsi;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eBarberShop.Controllers
{
    [ApiController]
    public class KorisniciController : BaseCRUDController<Korisnici, KorisniciInsertRequest, KorisniciUpdateRequest>
    {
        public KorisniciController(ILogger<BaseCRUDController<Korisnici, KorisniciInsertRequest, KorisniciUpdateRequest>> logger, IKorisniciService service) : base(logger, service)
        {
        }
    }
}
