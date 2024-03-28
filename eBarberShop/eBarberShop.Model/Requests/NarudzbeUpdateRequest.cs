namespace eBarberShop.Model.Requests
{
    public class NarudzbeUpdateRequest
    {
        public DateTime DatumNarudzbe { get; set; }
        public decimal UkupanIznos { get; set; }
        public bool Status { get; set; }
        public bool? Otkazano { get; set; }
        public int KorisnikId { get; set; }
    }
}
