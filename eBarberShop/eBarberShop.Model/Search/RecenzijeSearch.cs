﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eBarberShop.Model.Search
{
    public class RecenzijeSearch : BaseSearch
    {
        public DateTime? DatumObjave { get; set; }
        public bool? isKorisnikInclude { get; set; }
    }
}
