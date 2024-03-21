namespace eBarberShop.Model
{
    public class SlikeUsluge
    {
        public int SlikeUslugeId { get; set; }
        public int SlikaId { get; set; }

        public virtual Slike Slika { get; set; }

        public byte[]? SlikaUsluga => Slika?.Slika;
        public string? OpisSlike => Slika?.Opis;
        public DateTime? DatumObjave => Slika?.DatumPostavljanja;
    }
}
