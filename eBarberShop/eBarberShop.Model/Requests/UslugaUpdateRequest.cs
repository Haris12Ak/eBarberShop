using System.ComponentModel.DataAnnotations;

namespace eBarberShop.Model.Requests
{
    public class UslugaUpdateRequest
    {
        [Required(AllowEmptyStrings = false, ErrorMessage = "Obavezno polje")]
        public string Naziv { get; set; }

        public string? Opis { get; set; }

        [Required(ErrorMessage = "Obavezno polje")]
        [RegularExpression(@"^\d+(\.\d{1,2})?$", ErrorMessage = "Dozvoljen unos samo brojeva!")]
        public decimal Cijena { get; set; }

        public int? Trajanje { get; set; }

        public byte[]? Slika { get; set; }
    }
}
