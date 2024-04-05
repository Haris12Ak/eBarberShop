using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eBarberShop.Model.Search
{
    public class ProizvodiSearch : BaseSearch
    {
        public string? Naziv { get; set; }
        public string? Sifra { get; set; }
        public string? VrstaProizvoda { get; set; }
        public bool? IsVrsteProizvodaIncluded { get; set; }


    }
}
