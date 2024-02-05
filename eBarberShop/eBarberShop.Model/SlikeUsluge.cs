using eBarberShop.Model.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eBarberShop.Model
{
    public class SlikeUsluge
    {
        public int SlikeUslugeId { get; set; }
        public int UslugaId { get; set; }
        public int SlikaId { get; set; }

        public virtual Usluga Usluga { get; set; }
        public virtual Slike Slika { get; set; }
    }
}
