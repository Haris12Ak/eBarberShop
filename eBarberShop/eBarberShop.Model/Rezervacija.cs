namespace eBarberShop.Model
{
    public class Rezervacija
    {
        public int RezervacijaId { get; set; }
        public DateTime Datum { get; set; }
        public DateTime Vrijeme { get; set; }
        public bool? Status { get; set; }
        public int KorisnikId { get; set; }
        public int UposlenikId { get; set; }

        public virtual Korisnici Korisnik { get; set; }
        public virtual Uposlenik Uposlenik { get; set; }

        public virtual ICollection<RezervacijaUsluge> RezervacijaUsluge { get; set; } = new List<RezervacijaUsluge>();
    }
}
