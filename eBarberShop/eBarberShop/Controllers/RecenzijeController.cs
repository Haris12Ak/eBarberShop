using eBarberShop.Model;
using eBarberShop.Model.Requests;
using eBarberShop.Model.Search;
using eBarberShop.Services.Interfejsi;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eBarberShop.Controllers
{
    [ApiController]
    public class RecenzijeController : BaseCRUDController<Recenzije, RecenzijeSearch, RecenzijeInsertRequest, RecenzijeUpdateRequest>
    {
        public RecenzijeController(ILogger<BaseCRUDController<Recenzije, RecenzijeSearch, RecenzijeInsertRequest, RecenzijeUpdateRequest>> logger, IRecenzijeService service) : base(logger, service)
        {
        }
    }
}
