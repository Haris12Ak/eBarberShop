namespace eBarberShop.Model
{
    public class NarudzbeDetalji
    {
        public int NarudzbeDetaljiId { get; set; }
        public int Kolicina { get; set; }
        public int NarudzbaId { get; set; }
        public int ProizvodId { get; set; }

        public virtual Proizvodi Proizvod { get; set; }

        public decimal? CijenaProizvoda => Proizvod?.Cijena;
        public string? NazivProizvoda => Proizvod?.Naziv;
        public string? SifraProizvoda => Proizvod?.Sifra;

    }
}
