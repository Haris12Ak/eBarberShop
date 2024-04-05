namespace eBarberShop.Model.Search
{
    public class NarudzbeSearch : BaseSearch
    {
        public string? BrojNarudzbe { get; set; }
        public DateTime? DatumNarudzbe { get; set; }
        public bool? isKorisnikIncluded { get; set; }
    }
}
