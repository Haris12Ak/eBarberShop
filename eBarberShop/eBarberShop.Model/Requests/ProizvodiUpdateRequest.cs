using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eBarberShop.Model.Requests
{
    public class ProizvodiUpdateRequest
    {
        public decimal Cijena { get; set; }
        public string Naziv { get; set; }
        public string Sifra { get; set; }
        public string? Opis { get; set; }
        public byte[]? Slika { get; set; }
        public bool? Status { get; set; }
        public int VrstaProizvodaId { get; set; }
    }
}
