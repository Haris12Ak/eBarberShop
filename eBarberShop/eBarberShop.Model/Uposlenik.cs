namespace eBarberShop.Model
{
    public class Uposlenik
    {
        public int UposlenikId { get; set; }
        public string Ime { get; set; }
        public string Prezime { get; set; }
        public string KontaktTelefon { get; set; }
        public string? Email { get; set; }
        public string? Adresa { get; set; }
        public double? ProsjecnaOcjena { get; set; }
    }
}
