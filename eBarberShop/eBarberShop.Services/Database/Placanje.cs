using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eBarberShop.Services.Database
{
    public partial class Placanje
    {
        public int PlacanjeId { get; set; }
        public DateTime DatumUplate { get; set; }
        public decimal Iznos { get; set; }
        public bool? Status { get; set; }
        public int NarudzbaId { get; set; }

        public virtual Narudzbe Narudzba { get; set; }

    }
}
