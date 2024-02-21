namespace eBarberShop.Model
{
    public class Novosti
    {
        public int NovostiId { get; set; }
        public string Naslov { get; set; }
        public string Sadrzaj { get; set; }
        public DateTime DatumObjave { get; set; }
        public byte[]? Slika { get; set; }
        public int KorisnikId { get; set; }
        public Korisnici Korisnik { get; set; }

        public string? KorisnikImePrezime => Korisnik?.Ime + " " + Korisnik?.Prezime;
    }
}
