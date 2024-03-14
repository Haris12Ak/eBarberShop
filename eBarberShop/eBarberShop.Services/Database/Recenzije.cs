namespace eBarberShop.Services.Database
{
    public partial class Recenzije
    {
        public int RecenzijeId { get; set; }
        public string Sadrzaj { get; set; }
        public double Ocjena { get; set; }
        public DateTime DatumObjave { get; set; }
        public int KorisnikId { get; set; }

        public virtual Korisnici Korisnik { get; set; }
    }
}
