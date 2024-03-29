namespace eBarberShop.Services.Database
{
    public partial class Proizvodi
    {
        public int ProizvodiId { get; set; }
        public decimal Cijena { get; set; }
        public string Naziv { get; set; }
        public string Sifra { get; set; }
        public string? Opis { get; set; }
        public byte[]? Slika { get; set; }
        public bool? Status { get; set; }
        public int VrstaProizvodaId { get; set; }

        public virtual VrsteProizvoda VrstaProizvoda { get; set; }

        public virtual ICollection<NarudzbeDetalji> NarudzbeDetalji { get; set; } = new List<NarudzbeDetalji>();
    }
}
