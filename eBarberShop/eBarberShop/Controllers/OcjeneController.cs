using eBarberShop.Model;
using eBarberShop.Model.Requests;
using eBarberShop.Model.Search;
using eBarberShop.Services.Interfejsi;
using Microsoft.AspNetCore.Mvc;

namespace eBarberShop.Controllers
{
    [ApiController]
    public class OcjeneController : BaseCRUDController<Ocjene, OcjeneSearch, OcjeneInsertRequest, OcjeneUpdateRequest>
    {
        public OcjeneController(ILogger<BaseCRUDController<Ocjene, OcjeneSearch, OcjeneInsertRequest, OcjeneUpdateRequest>> logger, IOcjeneService service) : base(logger, service)
        {
        }

        [HttpGet("/GetOcjeneByUposlenikId/{uposlenikId}")]
        public async Task<List<Ocjene>> GetOcjene(int uposlenikId)
        {
            return await (_service as IOcjeneService).GetOcjeneByUposlenikId(uposlenikId);
        }
    }
}
