using eBarberShop.Model;
using eBarberShop.Model.Requests;
using eBarberShop.Model.Search;
using eBarberShop.Services.Interfejsi;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eBarberShop.Controllers
{
    [ApiController]
    public class ProizvodiController : BaseCRUDController<Proizvodi, ProizvodiSearch, ProizvodiInsertRequest, ProizvodiUpdateRequest>
    {
        public ProizvodiController(ILogger<BaseCRUDController<Proizvodi, ProizvodiSearch, ProizvodiInsertRequest, ProizvodiUpdateRequest>> logger, IProizvodiService service) : base(logger, service)
        {
        }
    }
}
