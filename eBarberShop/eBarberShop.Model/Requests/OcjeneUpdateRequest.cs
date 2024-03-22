namespace eBarberShop.Model.Requests
{
    public class OcjeneUpdateRequest
    {
        public DateTime Datum { get; set; }
        public double Ocjena { get; set; }
        public string? Opis { get; set; }
        public int UposlenikId { get; set; }
        public int KorisnikId { get; set; }
    }
}
