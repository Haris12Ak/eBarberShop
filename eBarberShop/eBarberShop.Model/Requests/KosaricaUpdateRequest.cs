using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eBarberShop.Model.Requests
{
    public class KosaricaUpdateRequest
    {
        public int Kolicina { get; set; }
        public decimal? UkupanIznos { get; set; }
        public int KorisnikId { get; set; }
        public int ProizvodId { get; set; }
    }
}
