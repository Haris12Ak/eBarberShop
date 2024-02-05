using eBarberShop.Model;
using eBarberShop.Model.Requests;
using eBarberShop.Model.Search;
using eBarberShop.Services.Interfejsi;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eBarberShop.Controllers
{
    [ApiController]
    public class KosaricaController : BaseCRUDController<Kosarica, KosaricaSearch, KosaricaInsertRequest, KosaricaUpdateRequest>
    {
        public KosaricaController(ILogger<BaseCRUDController<Kosarica, KosaricaSearch, KosaricaInsertRequest, KosaricaUpdateRequest>> logger, IKosaricaService service) : base(logger, service)
        {
        }
    }
}
