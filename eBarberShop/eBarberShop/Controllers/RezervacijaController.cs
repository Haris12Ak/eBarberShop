using eBarberShop.Model;
using eBarberShop.Model.Requests;
using eBarberShop.Model.Search;
using eBarberShop.Services.Interfejsi;
using Microsoft.AspNetCore.Mvc;

namespace eBarberShop.Controllers
{
    [ApiController]
    public class RezervacijaController : BaseCRUDController<Rezervacija, RezervacijaSearch, RezervacijaInsertRequest, RezervacijaUpdateRequest>
    {
        public RezervacijaController(ILogger<BaseCRUDController<Rezervacija, RezervacijaSearch, RezervacijaInsertRequest, RezervacijaUpdateRequest>> logger, IRezervacijaService service) : base(logger, service)
        {
        }

        [HttpGet("/GetTermine")]
        public async Task<List<Model.Termini>> GetTermine([FromQuery] TerminiSearch? search)
        {
            return await (_service as IRezervacijaService).GetTermine(search);
        }

        [HttpPost("/RezervisiTermin/{uslugaId}")]
        public async Task<Model.Rezervacija> RezervisiTermin(int uslugaId, [FromBody] RezervacijaInsertRequest request)
        {
            return await (_service as IRezervacijaService).RezervisiTermin(uslugaId, request);
        }

        [HttpGet("/GetTermineByKorisnikId/{korisnikId}")]
        public async Task<List<Model.TerminiKorisnikaInfo>> GetTermineByKorisnikId(int korisnikId)
        {
            return await (_service as IRezervacijaService).GetTermineByKorisnikId(korisnikId);
        }
    }
}
