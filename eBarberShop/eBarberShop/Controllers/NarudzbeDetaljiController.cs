﻿using eBarberShop.Model;
using eBarberShop.Model.Requests;
using eBarberShop.Model.Search;
using eBarberShop.Services.Interfejsi;
using Microsoft.AspNetCore.Mvc;

namespace eBarberShop.Controllers
{
    [ApiController]
    public class NarudzbeDetaljiController : BaseCRUDController<NarudzbeDetalji, BaseSearch, NarudzbeDetaljiInsertRequest, NarudzbeDetaljiUpdateRequest>
    {
        public NarudzbeDetaljiController(ILogger<BaseCRUDController<NarudzbeDetalji, BaseSearch, NarudzbeDetaljiInsertRequest, NarudzbeDetaljiUpdateRequest>> logger, INarudzbeDetaljiService service) : base(logger, service)
        {
        }

        [HttpGet("/GetNarudzbeDetaljiByNarudzbaId/{narudzbaId}")]
        public async Task<List<NarudzbeDetalji>> GetNarudzbeDetalji(int narudzbaId)
        {
            return await (_service as INarudzbeDetaljiService).GetNarudzbeDetaljiByNarudzbaId(narudzbaId);
        }
    }
}
