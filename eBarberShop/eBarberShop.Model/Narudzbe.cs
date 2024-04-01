namespace eBarberShop.Model
{
    public class Narudzbe
    {
        public int NarudzbeId { get; set; }
        public string BrojNarudzbe { get; set; }
        public DateTime DatumNarudzbe { get; set; }
        public decimal UkupanIznos { get; set; }
        public bool Status { get; set; }
        public bool? Otkazano { get; set; }
        public int KorisnikId { get; set; }

        public virtual Korisnici Korisnik { get; set; }

        public string? imeKorisnika => Korisnik?.Ime;
        public string? prezimeKorisnika => Korisnik?.Prezime;
        public string? emailKorisnika => Korisnik?.Email;
        public string? adersaKorisnika => Korisnik?.Adresa;
        public string? brojTelefonaKorisnika => Korisnik?.BrojTelefona;
        public string? mjestoBoravkaKorisnika => Korisnik.Grad?.Naziv;

    }
}
