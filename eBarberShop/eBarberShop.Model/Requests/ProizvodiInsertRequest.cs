using System.ComponentModel.DataAnnotations;

namespace eBarberShop.Model.Requests
{
    public class ProizvodiInsertRequest
    {
        [Required(AllowEmptyStrings = false, ErrorMessage = "Obavezno polje")]
        public string Naziv { get; set; }

        [Required(ErrorMessage = "Obavezno polje")]
        [RegularExpression(@"^\d+(\.\d{1,2})?$", ErrorMessage = "Dozvoljen unos samo brojeva!")]
        public decimal Cijena { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessage = "Obavezno polje")]
        public string Sifra { get; set; }

        public string? Opis { get; set; }

        public byte[]? Slika { get; set; }

        public bool? Status { get; set; }

        [Required(ErrorMessage = "Obavezno polje")]
        public int VrstaProizvodaId { get; set; }
    }
}
