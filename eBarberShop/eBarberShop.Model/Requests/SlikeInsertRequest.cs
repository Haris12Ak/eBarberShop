using System.ComponentModel.DataAnnotations;

namespace eBarberShop.Model.Requests
{
    public class SlikeInsertRequest
    {
        public string? Opis { get; set; }

        [Required(ErrorMessage = "Obavezno polje")]
        public byte[] Slika { get; set; }

        [Required(ErrorMessage = "Obavezno polje")]
        public DateTime DatumPostavljanja { get; set; }
    }
}
