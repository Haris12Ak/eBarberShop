using System.ComponentModel.DataAnnotations;

namespace eBarberShop.Model.Requests
{
    public class KorisniciInsertRequest
    {
        [Required(AllowEmptyStrings = false, ErrorMessage = "Obavezno polje")]
        [RegularExpression(@"^[a-zA-Z]+$", ErrorMessage = "Unseite ispravno vase ime! Dozvoljen unos samo slova")]
        public string Ime { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessage = "Obavezno polje")]
        [RegularExpression(@"^[a-zA-Z]+$", ErrorMessage = "Unseite ispravno vase prezime!  Dozvoljen unos samo slova")]
        public string Prezime { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessage = "Obavezno polje")]
        [RegularExpression(@"^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$", ErrorMessage = "Unseite ispravno Email! Example (namesurname@gmail.com)")]
        public string Email { get; set; }

        public string? Adresa { get; set; }

        [RegularExpression(@"^\d{9,}$", ErrorMessage = "Unseite ispravno broj telefona! Format (06XXXXXXX)")]
        public string? BrojTelefona { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessage = "Obavezno polje")]
        [RegularExpression(@"^[a-zA-Z0-9]+$", ErrorMessage = "Unseite ispravno korisniko ime! Nisu dozvoljeni specijalni karakteri!")]
        public string KorisnickoIme { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessage = "Obavezno polje")]
        [StringLength(15, ErrorMessage = "Lozinka mora biti duza od 4 slova", MinimumLength = 4)]
        [Compare("LozinkaPotvrda", ErrorMessage = "Lozinke se ne podudaraju.")]
        public string Lozinka { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessage = "Obavezno polje")]
        [StringLength(15, ErrorMessage = "Lozinka mora biti duza od 4 slova", MinimumLength = 4)]
        [Compare("Lozinka", ErrorMessage = "Lozinke se ne podudaraju.")]
        public string LozinkaPotvrda { get; set; }

        public bool? Status { get; set; }

        public byte[]? Slika { get; set; }

        [Required(ErrorMessage = "Obavezno polje")]
        public int GradId { get; set; }
    }
}
