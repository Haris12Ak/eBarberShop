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
        private readonly IKorisniciService _korisniciService;

        public KorisniciController(ILogger<BaseCRUDController<Korisnici, KorisniciSearch, KorisniciInsertRequest, KorisniciUpdateRequest>> logger, IKorisniciService korisniciService) : base(logger, korisniciService)
        {
            _korisniciService = korisniciService;
        }

        [AllowAnonymous]
        [HttpGet("/Login")]
        public async Task<Model.Korisnici> Login([FromQuery] KorisniciLoginRequest request)
        {
            return await _korisniciService.Login(request.Username, request.Password);
        }

        [AllowAnonymous]
        [HttpPost]
        public override Task<Korisnici> Insert([FromBody] KorisniciInsertRequest insert)
        {
            return base.Insert(insert);
        }
    }
}
