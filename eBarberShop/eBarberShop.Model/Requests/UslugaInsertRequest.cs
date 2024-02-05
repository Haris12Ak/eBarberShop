﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eBarberShop.Model.Requests
{
    public class UslugaInsertRequest
    {
        public string Naziv { get; set; }
        public string? Opis { get; set; }
        public decimal Cijena { get; set; }
        public int? Trajanje { get; set; }
    }
}
