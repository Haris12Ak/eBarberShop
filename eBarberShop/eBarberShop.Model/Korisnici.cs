using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eBarberShop.Model
{
    public class Korisnici
    {
        public int KorisniciId { get; set; }
        public string Ime { get; set; }
        public string Prezime { get; set; }
        public string Email { get; set; }
        public string? Adresa { get; set; }
        public string? BrojTelefona { get; set; }
        public string KorisnickoIme { get; set; }
        public bool? Status { get; set; }
        public byte[]? Slika { get; set; }
        public int GradId { get; set; }

        public virtual ICollection<KorisniciUloge> KorisniciUloge { get; set; } = new List<KorisniciUloge>();
    }
}
