using eBarberShop.Model;
using eBarberShop.Model.Requests;
using eBarberShop.Model.Search;
using eBarberShop.Services.Interfejsi;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace eBarberShop.Controllers
{
    [ApiController]
    public class KorisniciController : BaseCRUDController<Korisnici, KorisniciSearch, KorisniciInsertRequest, KorisniciUpdateRequest>
    {
        public KorisniciController(ILogger<BaseCRUDController<Korisnici, KorisniciSearch, KorisniciInsertRequest, KorisniciUpdateRequest>> logger, IKorisniciService service) : base(logger, service)
        {
        }

        [AllowAnonymous]
        [HttpGet("/Login")]
        public async Task<Model.Korisnici> Login([FromQuery] KorisniciLoginRequest request)
        {
            return await (_service as IKorisniciService).Login(request.Username, request.Password);
        }
    }
}
