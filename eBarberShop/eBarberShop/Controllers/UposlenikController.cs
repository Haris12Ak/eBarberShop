using eBarberShop.Model;
using eBarberShop.Model.Requests;
using eBarberShop.Model.Search;
using eBarberShop.Services.Interfejsi;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace eBarberShop.Controllers
{
    [ApiController]
    public class UposlenikController : BaseCRUDController<Uposlenik, UposlenikSearch, UposlenikInsertRequest, UposlenikUpdateRequest>
    {
        public UposlenikController(ILogger<BaseCRUDController<Uposlenik, UposlenikSearch, UposlenikInsertRequest, UposlenikUpdateRequest>> logger, IUposlenikService service) : base(logger, service)
        {
        }

        [Authorize(Roles = "Administrator")]
        public override Task<Uposlenik> Insert([FromBody] UposlenikInsertRequest insert)
        {
            return base.Insert(insert);
        }

        [Authorize(Roles = "Administrator")]
        public override Task<Uposlenik> Update(int id, [FromBody] UposlenikUpdateRequest update)
        {
            return base.Update(id, update);
        }

        [Authorize(Roles = "Administrator")]
        public override Task<Uposlenik> Delete(int id)
        {
            return base.Delete(id);
        }
    }
}
