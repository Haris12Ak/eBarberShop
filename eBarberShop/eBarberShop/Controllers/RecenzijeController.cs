using eBarberShop.Model.Requests;
using eBarberShop.Model.Search;
using eBarberShop.Services.Interfejsi;
using eBarberShop.Services.Servisi;
using Microsoft.AspNetCore.Mvc;

namespace eBarberShop.Controllers
{
    [ApiController]
    public class RecenzijeController : BaseCRUDController<Model.Recenzije, RecenzijeSearch, RecenzijeInsertRequest, RecenzijeUpdateRequest>
    {
        public RecenzijeController(ILogger<BaseCRUDController<Model.Recenzije, RecenzijeSearch, RecenzijeInsertRequest, RecenzijeUpdateRequest>> logger, IRecenzijeService service) : base(logger, service)
        {
        }

        [HttpGet("/GetRecenzijeByKorisnikId/{korisnikId}")]
        public async Task<List<Model.Recenzije>> GetRecenzije(int korisnikId)
        {
            return await (_service as RecenzijeService).GetRecenzijeByKorisnikId(korisnikId);
        }
    }
}
