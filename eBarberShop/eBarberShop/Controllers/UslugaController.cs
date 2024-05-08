using eBarberShop.Model;
using eBarberShop.Model.Requests;
using eBarberShop.Model.Search;
using eBarberShop.Services.Interfejsi;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace eBarberShop.Controllers
{
    [ApiController]
    public class UslugaController : BaseCRUDController<Usluga, UslugaSearch, UslugaInsertRequest, UslugaUpdateRequest>
    {
        public UslugaController(ILogger<BaseCRUDController<Usluga, UslugaSearch, UslugaInsertRequest, UslugaUpdateRequest>> logger, IUslugaService service) : base(logger, service)
        {
        }

        [Authorize(Roles = "Administrator")]
        public override Task<Usluga> Insert([FromBody] UslugaInsertRequest insert)
        {
            return base.Insert(insert);
        }

        [Authorize(Roles = "Administrator")]
        public override Task<Usluga> Update(int id, [FromBody] UslugaUpdateRequest update)
        {
            return base.Update(id, update);
        }

        [Authorize(Roles = "Administrator")]
        public override Task<Usluga> Delete(int id)
        {
            return base.Delete(id);
        }
    }
}
