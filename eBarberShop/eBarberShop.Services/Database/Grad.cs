using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eBarberShop.Services.Database
{
    public partial class Grad
    {
        public int GradId { get; set; }
        public int DrzavaId { get; set; }
        public string Naziv { get; set; }
        public string? Opis { get; set; } = null;

        public virtual Drzava Drzava { get; set; }

        public virtual ICollection<Korisnici> Korisnici { get; set; } = new List<Korisnici>();
    }
}
