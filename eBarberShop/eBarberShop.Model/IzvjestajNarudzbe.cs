namespace eBarberShop.Model
{
    public class IzvjestajNarudzbe
    {
        public decimal Ukupno { get; set; }
        public string NajviseProdavaniProizvod { get; set; }
        public List<NarudzbaIfno> NarudzbaInfo { get; set; } = new List<NarudzbaIfno> { };
    }

    public class NarudzbaIfno
    {
        public DateTime DatumNarudzbe { get; set; }
        public decimal UkupanIznos { get; set; }
        public List<ListOfNarudzbe> Narudzbe { get; set; } = new List<ListOfNarudzbe> { };
    }

    public class ListOfNarudzbe
    {
        public string BrojNarudzbe { get; set; }
        public decimal Naplata { get; set; }
        public int KorisnikId { get; set; }
        public string? ImeKorisnika { get; set; }
        public string? PrezimeKorisnika { get; set; }
    }
}
