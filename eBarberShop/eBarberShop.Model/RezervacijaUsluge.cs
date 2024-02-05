using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eBarberShop.Model
{
    public class RezervacijaUsluge
    {
        public int RezervacijaUslugeId { get; set; }
        public int RezervacijaId { get; set; }
        public int UslugaId { get; set; }

        public virtual Rezervacija Rezervacija { get; set; }
        public virtual Usluga Usluga { get; set; }
    }
}
