using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eBarberShop.Model
{
    public class NarudzbeDetalji
    {
        public int NarudzbeDetaljiId { get; set; }
        public int Kolicina { get; set; }
        public int NarudzbaId { get; set; }
        public int ProizvodId { get; set; }

        public virtual Proizvodi Proizvod { get; set; }
    }
}
