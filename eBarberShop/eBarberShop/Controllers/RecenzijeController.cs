using eBarberShop.Model.Requests;
using eBarberShop.Model.Search;
using eBarberShop.Services.Interfejsi;
using Microsoft.AspNetCore.Mvc;

namespace eBarberShop.Controllers
{
    [ApiController]
    public class RecenzijeController : BaseCRUDController<Model.Recenzije, RecenzijeSearch, RecenzijeInsertRequest, RecenzijeUpdateRequest>
    {
        private readonly IRecenzijeService _recenzijeService;
        public RecenzijeController(ILogger<BaseCRUDController<Model.Recenzije, RecenzijeSearch, RecenzijeInsertRequest, RecenzijeUpdateRequest>> logger, IRecenzijeService recenzijeService) : base(logger, recenzijeService)
        {
            _recenzijeService = recenzijeService;
        }

        [HttpGet("/GetRecenzijeByKorisnikId/{korisnikId}")]
        public async Task<List<Model.Recenzije>> GetRecenzije(int korisnikId)
        {
            return await _recenzijeService.GetRecenzijeByKorisnikId(korisnikId);
        }
    }
}
