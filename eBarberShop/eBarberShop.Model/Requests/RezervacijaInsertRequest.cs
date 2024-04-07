using System.ComponentModel.DataAnnotations;

namespace eBarberShop.Model.Requests
{
    public class RezervacijaInsertRequest
    {
        [Required(ErrorMessage = "Obavezno polje")]
        public DateTime Datum { get; set; }

        [Required(ErrorMessage = "Obavezno polje")]
        public DateTime Vrijeme { get; set; }

        public bool? Status { get; set; }

        [Required(ErrorMessage = "Obavezno polje")]
        public int KorisnikId { get; set; }

        [Required(ErrorMessage = "Obavezno polje")]
        public int UposlenikId { get; set; }

        [Required(ErrorMessage = "Obavezno polje")]
        public int UslugaId { get; set; }
    }
}
