using System.ComponentModel.DataAnnotations;

namespace eBarberShop.Model.Requests
{
    public class NovostiInsertRequest
    {
        [Required(AllowEmptyStrings = false, ErrorMessage = "Obavezno polje")]
        public string Naslov { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessage = "Obavezno polje")]
        public string Sadrzaj { get; set; }

        [Required(ErrorMessage = "Obavezno polje")]
        public DateTime DatumObjave { get; set; }

        public byte[]? Slika { get; set; }

        [Required(ErrorMessage = "Obavezno polje")]
        public int KorisnikId { get; set; }
    }
}
