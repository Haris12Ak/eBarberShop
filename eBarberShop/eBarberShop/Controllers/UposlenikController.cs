using eBarberShop.Model;
using eBarberShop.Model.Requests;
using eBarberShop.Model.Search;
using eBarberShop.Services.Interfejsi;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eBarberShop.Controllers
{
    [ApiController]
    public class UposlenikController : BaseCRUDController<Uposlenik, UposlenikSearch, UposlenikInsertRequest, UposlenikUpdateRequest>
    {
        public UposlenikController(ILogger<BaseCRUDController<Uposlenik, UposlenikSearch, UposlenikInsertRequest, UposlenikUpdateRequest>> logger, IUposlenikService service) : base(logger, service)
        {
        }
    }
}
