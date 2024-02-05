using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eBarberShop.Model
{
    public class Slike
    {
        public int SlikeId { get; set; }
        public string? Opis { get; set; }
        public byte[] Slika { get; set; }
        public DateTime DatumPostavljanja { get; set; }

        public virtual ICollection<SlikeUsluge> SlikeUsluge { get; set; } = new List<SlikeUsluge>();
    }
}
