﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eBarberShop.Model
{
    public class Uloge
    {
        public int UlogeId { get; set; }
        public string Naziv { get; set; }
        public string? Opis { get; set; }

        public virtual ICollection<KorisniciUloge> KorisniciUloge { get; set; } = new List<KorisniciUloge>();
    }
}
