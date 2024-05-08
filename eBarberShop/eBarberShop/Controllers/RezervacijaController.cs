﻿using eBarberShop.Model;
using eBarberShop.Model.Requests;
using eBarberShop.Model.Search;
using eBarberShop.Services.Interfejsi;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace eBarberShop.Controllers
{
    [ApiController]
    public class RezervacijaController : BaseCRUDController<Rezervacija, RezervacijaSearch, RezervacijaInsertRequest, RezervacijaUpdateRequest>
    {
        private readonly IRezervacijaService _rezervacijaService;

        public RezervacijaController(ILogger<BaseCRUDController<Rezervacija, RezervacijaSearch, RezervacijaInsertRequest, RezervacijaUpdateRequest>> logger, IRezervacijaService rezervacijaService) : base(logger, rezervacijaService)
        {
            _rezervacijaService = rezervacijaService;
        }

        [HttpGet("/GetTermine")]
        public async Task<List<Model.Termini>> GetTermine([FromQuery] TerminiSearch? search)
        {
            return await _rezervacijaService.GetTermine(search);
        }

        [HttpGet("/GetTermineByKorisnikId/{korisnikId}")]
        public async Task<List<Model.TerminiKorisnikaInfo>> GetTermineByKorisnikId(int korisnikId)
        {
            return await _rezervacijaService.GetTermineByKorisnikId(korisnikId);
        }

        [Authorize(Roles = "Administrator, Uposlenik")]
        [HttpGet("/IzvjestajRezervacije")]
        public async Task<IzvjestajRezervacije> GetIzvjestajRezervacije([FromQuery] IzvjestajRezervacijeSearch? search)
        {
            return await _rezervacijaService.GetIzvjestajRezervacije(search);
        }

        [Authorize(Roles = "Administrator, Uposlenik")]
        [HttpGet("/GetTermineUposlenika")]
        public async Task<List<TerminiUposlenika>> GetTermineUposlenika([FromQuery] TerminiUposlenikaSearch? search)
        {
            return await _rezervacijaService.GetTermineUposlenika(search);
        }

    }
}
