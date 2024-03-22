namespace eBarberShop.Services.Database
{
    public partial class Uposlenik
    {
        public int UposlenikId { get; set; }
        public string Ime { get; set; }
        public string Prezime { get; set; }
        public string KontaktTelefon { get; set; }
        public string? Email { get; set; }
        public string? Adresa { get; set; }

        public virtual ICollection<Rezervacija> Rezervacije { get; set; } = new List<Rezervacija>();
        public virtual ICollection<Ocjene> Ocjene { get; set; } = new List<Ocjene>();

    }
}
