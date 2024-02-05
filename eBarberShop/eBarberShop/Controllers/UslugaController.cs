using eBarberShop.Model;
using eBarberShop.Model.Requests;
using eBarberShop.Model.Search;
using eBarberShop.Services.Interfejsi;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eBarberShop.Controllers
{
    [ApiController]
    public class UslugaController : BaseCRUDController<Usluga, UslugaSearch, UslugaInsertRequest, UslugaUpdateRequest>
    {
        public UslugaController(ILogger<BaseCRUDController<Usluga, UslugaSearch, UslugaInsertRequest, UslugaUpdateRequest>> logger, IUslugaService service) : base(logger, service)
        {
        }
    }
}
