using eBarberShop.Model;
using eBarberShop.Model.Requests;
using eBarberShop.Model.Search;
using eBarberShop.Services.Interfejsi;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eBarberShop.Controllers
{
    [ApiController]
    public class NovostiController : BaseCRUDController<Novosti, NovostiSearch, NovostiInsertRequest, NovostiUpdateRequest>
    {
        public NovostiController(ILogger<BaseCRUDController<Novosti, NovostiSearch, NovostiInsertRequest, NovostiUpdateRequest>> logger, INovostiService service) : base(logger, service)
        {
        }
    }
}
