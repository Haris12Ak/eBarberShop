using eBarberShop.Model;
using eBarberShop.Model.Requests;
using eBarberShop.Model.Search;
using eBarberShop.Services.Interfejsi;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace eBarberShop.Controllers
{
    [ApiController]
    public class NovostiController : BaseCRUDController<Novosti, NovostiSearch, NovostiInsertRequest, NovostiUpdateRequest>
    {
        public NovostiController(ILogger<BaseCRUDController<Novosti, NovostiSearch, NovostiInsertRequest, NovostiUpdateRequest>> logger, INovostiService service) : base(logger, service)
        {
        }

        [Authorize(Roles = "Administrator, Uposlenik")]
        public override Task<Novosti> Insert([FromBody] NovostiInsertRequest insert)
        {
            return base.Insert(insert);
        }

        [Authorize(Roles = "Administrator, Uposlenik")]
        public override Task<Novosti> Update(int id, [FromBody] NovostiUpdateRequest update)
        {
            return base.Update(id, update);
        }

        [Authorize(Roles = "Administrator, Uposlenik")]
        public override Task<Novosti> Delete(int id)
        {
            return base.Delete(id);
        }
    }
}
