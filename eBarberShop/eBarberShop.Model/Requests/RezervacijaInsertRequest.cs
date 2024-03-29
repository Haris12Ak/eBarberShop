namespace eBarberShop.Model.Requests
{
    public class RezervacijaInsertRequest
    {
        public DateTime Datum { get; set; }
        public DateTime Vrijeme { get; set; }
        public bool? Status { get; set; }
        public int KorisnikId { get; set; }
        public int UposlenikId { get; set; }
        public int UslugaId { get; set; }
    }
}
