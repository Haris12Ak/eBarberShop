using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eBarberShop.Services.Database
{
    public partial class Novosti
    {
        public int NovostiId { get; set; }
        public string Naslov { get; set; }
        public string Sadrzaj { get; set; }
        public DateTime DatumObjave { get; set; }
        public byte[]? Slika { get; set; }
        public int KorisnikId { get; set; }

        public virtual Korisnici Korisnik { get; set; }
    }
}
