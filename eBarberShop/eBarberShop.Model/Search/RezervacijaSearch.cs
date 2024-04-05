namespace eBarberShop.Model.Search
{
    public class RezervacijaSearch : BaseSearch
    {
        public DateTime? Datum { get; set; }
        public string? ImePrezimeUposlenika { get; set; }
        public string? ImePrezimeKorisnika { get; set; }
        public string? NazivUsluge { get; set; }
        public bool? IsUslugaIncluded { get; set; }
        public bool? IsKorisnikIncluded { get; set; }
        public bool? IsUposlenikIncluded { get; set; }

    }
}
