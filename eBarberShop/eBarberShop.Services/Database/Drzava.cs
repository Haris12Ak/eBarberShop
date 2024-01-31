using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eBarberShop.Services.Database
{
    public partial class Drzava
    {
        public int DrzavaId { get; set; }
        public string Naziv { get; set; }

        public virtual ICollection<Grad> Gradovi { get; set; } = new List<Grad>();
    }
}
