namespace eBarberShop.Model
{
    public class UslugaRezervacije
    {
        public int RezervacijaUslugeId { get; set; }
        public int RezervacijaId { get; set; }

        public virtual Rezervacija Rezervacija { get; set; }

        public DateTime? DatumRezervacije => Rezervacija?.Datum;
        public DateTime? VrijemeRezervacije => Rezervacija.Vrijeme;
        public string? ImeKlijenta => Rezervacija?.Korisnik.Ime;
        public string? PrezimeKlijenta => Rezervacija?.Korisnik.Prezime;

    }
}
