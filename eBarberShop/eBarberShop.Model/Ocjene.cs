namespace eBarberShop.Model
{
    public class Ocjene
    {
        public int Id { get; set; }
        public DateTime Datum { get; set; }
        public double Ocjena { get; set; }
        public string? Opis { get; set; }
        public int UposlenikId { get; set; }
        public int KorisnikId { get; set; }

        public Korisnici Korisnik { get; set; }

        public string? korisnickoIme => Korisnik?.KorisnickoIme;
    }
}
