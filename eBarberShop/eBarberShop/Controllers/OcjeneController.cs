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
        private readonly IOcjeneService _ocjeneService;
        public OcjeneController(ILogger<BaseCRUDController<Ocjene, OcjeneSearch, OcjeneInsertRequest, OcjeneUpdateRequest>> logger, IOcjeneService ocjeneService) : base(logger, ocjeneService)
        {
            _ocjeneService = ocjeneService;
        }

        [HttpGet("/GetOcjeneByUposlenikId/{uposlenikId}")]
        public async Task<List<Ocjene>> GetOcjene(int uposlenikId)
        {
            return await _ocjeneService.GetOcjeneByUposlenikId(uposlenikId);
        }
    }
}
