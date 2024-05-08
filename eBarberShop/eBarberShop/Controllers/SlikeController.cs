using eBarberShop.Model;
using eBarberShop.Model.Requests;
using eBarberShop.Model.Search;
using eBarberShop.Services.Interfejsi;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace eBarberShop.Controllers
{
    [ApiController]
    public class SlikeController : BaseCRUDController<Slike, SlikeSearch, SlikeInsertRequest, SlikeUpdateRequest>
    {
        public SlikeController(ILogger<BaseCRUDController<Slike, SlikeSearch, SlikeInsertRequest, SlikeUpdateRequest>> logger, ISlikeService service) : base(logger, service)
        {
        }

        [Authorize(Roles = "Administrator")]
        public override Task<Slike> Insert([FromBody] SlikeInsertRequest insert)
        {
            return base.Insert(insert);
        }

        [Authorize(Roles = "Administrator")]
        public override Task<Slike> Update(int id, [FromBody] SlikeUpdateRequest update)
        {
            return base.Update(id, update);
        }

        [Authorize(Roles = "Administrator")]
        public override Task<Slike> Delete(int id)
        {
            return base.Delete(id);
        }
    }
}
