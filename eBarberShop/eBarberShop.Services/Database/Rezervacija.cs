namespace eBarberShop.Services.Database
{
    public partial class Rezervacija
    {
        public int RezervacijaId { get; set; }
        public DateTime Datum { get; set; }
        public DateTime Vrijeme { get; set; }
        public bool? Status { get; set; }
        public int KorisnikId { get; set; }
        public int UposlenikId { get; set; }
        public int UslugaId { get; set; }

        public virtual Korisnici Korisnik { get; set; }
        public virtual Uposlenik Uposlenik { get; set; }
        public virtual Usluga Usluga { get; set; }
    }
}
