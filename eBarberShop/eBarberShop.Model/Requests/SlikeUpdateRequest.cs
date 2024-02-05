using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eBarberShop.Model.Requests
{
    public class SlikeUpdateRequest
    {
        public string? Opis { get; set; }
        public byte[] Slika { get; set; }
        public DateTime DatumPostavljanja { get; set; }
    }
}
