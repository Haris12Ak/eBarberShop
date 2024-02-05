using eBarberShop.Model;
using eBarberShop.Model.Requests;
using eBarberShop.Model.Search;
using eBarberShop.Services.Interfejsi;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace eBarberShop.Controllers
{
    [ApiController]
    public class VrsteProizvodaController : BaseCRUDController<VrsteProizvoda, VrsteProizvodaSearch, VrsteProizvodaInsertRequest, VrsteProizvodaUpdateRequest>
    {
        public VrsteProizvodaController(ILogger<BaseCRUDController<VrsteProizvoda, VrsteProizvodaSearch, VrsteProizvodaInsertRequest, VrsteProizvodaUpdateRequest>> logger, IVrsteProizvodaService service) : base(logger, service)
        {
        }
    }
}
