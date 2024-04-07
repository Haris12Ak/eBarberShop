using System.ComponentModel.DataAnnotations;

namespace eBarberShop.Model.Requests
{
    public class UposlenikUpdateRequest
    {
        [Required(AllowEmptyStrings = false, ErrorMessage = "Obavezno polje")]
        public string Ime { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessage = "Obavezno polje")]
        public string Prezime { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessage = "Obavezno polje")]
        public string KontaktTelefon { get; set; }

        public string? Email { get; set; }
        public string? Adresa { get; set; }
    }
}
