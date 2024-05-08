using eBarberShop.Model;
using eBarberShop.Model.Requests;
using eBarberShop.Model.Search;
using eBarberShop.Services.Interfejsi;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace eBarberShop.Controllers
{
    [ApiController]
    public class ProizvodiController : BaseCRUDController<Proizvodi, ProizvodiSearch, ProizvodiInsertRequest, ProizvodiUpdateRequest>
    {
        public ProizvodiController(ILogger<BaseCRUDController<Proizvodi, ProizvodiSearch, ProizvodiInsertRequest, ProizvodiUpdateRequest>> logger, IProizvodiService service) : base(logger, service)
        {
        }

        [Authorize(Roles = "Administrator")]
        public override Task<Proizvodi> Insert([FromBody] ProizvodiInsertRequest insert)
        {
            return base.Insert(insert);
        }

        [Authorize(Roles = "Administrator")]
        public override Task<Proizvodi> Update(int id, [FromBody] ProizvodiUpdateRequest update)
        {
            return base.Update(id, update);
        }

        [Authorize(Roles = "Administrator")]
        public override Task<Proizvodi> Delete(int id)
        {
            return base.Delete(id);
        }
    }
}
