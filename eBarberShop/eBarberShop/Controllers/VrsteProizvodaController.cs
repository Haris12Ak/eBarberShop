using eBarberShop.Model;
using eBarberShop.Model.Requests;
using eBarberShop.Model.Search;
using eBarberShop.Services.Interfejsi;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace eBarberShop.Controllers
{
    [ApiController]
    public class VrsteProizvodaController : BaseCRUDController<VrsteProizvoda, VrsteProizvodaSearch, VrsteProizvodaInsertRequest, VrsteProizvodaUpdateRequest>
    {
        public VrsteProizvodaController(ILogger<BaseCRUDController<VrsteProizvoda, VrsteProizvodaSearch, VrsteProizvodaInsertRequest, VrsteProizvodaUpdateRequest>> logger, IVrsteProizvodaService service) : base(logger, service)
        {
        }

        [Authorize(Roles = "Administrator")]
        public override Task<VrsteProizvoda> Insert([FromBody] VrsteProizvodaInsertRequest insert)
        {
            return base.Insert(insert);
        }

        [Authorize(Roles = "Administrator")]
        public override Task<VrsteProizvoda> Update(int id, [FromBody] VrsteProizvodaUpdateRequest update)
        {
            return base.Update(id, update);
        }

        [Authorize(Roles = "Administrator")]
        public override Task<VrsteProizvoda> Delete(int id)
        {
            return base.Delete(id);
        }
    }
}
