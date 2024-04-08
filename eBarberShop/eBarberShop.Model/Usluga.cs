namespace eBarberShop.Model
{
    public class Usluga
    {
        public int UslugaId { get; set; }
        public string Naziv { get; set; }
        public string? Opis { get; set; }
        public decimal Cijena { get; set; }
        public int? Trajanje { get; set; }
        public byte[]? Slika { get; set; }

        public virtual ICollection<SlikeUsluge> SlikeUsluge { get; set; } = new List<SlikeUsluge>();
    }
}
