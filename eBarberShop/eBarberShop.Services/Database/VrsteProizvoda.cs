using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eBarberShop.Services.Database
{
    public partial class VrsteProizvoda
    {
        public int VrsteProizvodaId { get; set; }
        public string Naziv { get; set; }
        public string? Opis { get; set; }

        public virtual ICollection<Proizvodi> Proizvodi { get; set; } = new List<Proizvodi>();
    }
}
