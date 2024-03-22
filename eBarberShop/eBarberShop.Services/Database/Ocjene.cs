namespace eBarberShop.Services.Database
{
    public partial class Ocjene
    {
        public int Id { get; set; }
        public DateTime Datum { get; set; }
        public double Ocjena { get; set; }
        public string? Opis { get; set; }
        public int UposlenikId { get; set; }
        public int KorisnikId { get; set; }


        public virtual Uposlenik Uposlenik { get; set; }
        public virtual Korisnici Korisnik { get; set; }
    }
}
