using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eBarberShop.Model
{
    public class Grad
    {
        public int GradId { get; set; }
        public string Naziv { get; set; }
        public string? Opis { get; set; } 
        public int DrzavaId { get; set; }
    }
}
