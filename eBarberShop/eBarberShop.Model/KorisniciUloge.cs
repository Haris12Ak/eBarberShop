using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eBarberShop.Model
{
    public class KorisniciUloge
    {
        public int KorisniciUlogeId { get; set; }
        public int KorisnikId { get; set; }
        public int UlogaId { get; set; }
        public DateTime DatumIzmjene { get; set; }

        public virtual Uloge Uloga { get; set; }
    }
}
