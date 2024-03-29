namespace eBarberShop.Model.Search
{
    public class RezervacijaSearch : BaseSearch
    {
        public bool? IsUslugaIncluded { get; set; }
        public DateTime? Datum { get; set; }
        public string? ImePrezimeUposlenika { get; set; }
    }
}
