using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eBarberShop.Services.Database
{
    public partial class Kosarica
    {
        public int KosaricaId { get; set; }
        public int Kolicina { get; set; }
        public decimal? UkupanIznos { get; set; }
        public int KorisnikId { get; set; }
        public int ProizvodId { get; set; }

        public virtual Korisnici Korisnik { get; set; }
        public virtual Proizvodi Proizvod { get; set; }

    }
}
