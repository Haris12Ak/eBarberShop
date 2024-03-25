namespace eBarberShop.Model
{
    public class ReservationNotifier
    {
        public ReservationNotifier()
        {
        }

        public int Id { get; set; }
        public string UposlenikIme { get; set; }
        public string UposlenikPrezime { get; set; }
        public string UslugaNaziv { get; set; }
        public decimal CijenaUsluge { get; set; }
        public string KorisnikIme { get; set; }
        public string Email { get; set; }
        public DateTime Datum { get; set; }
        public DateTime Vrijeme { get; set; }
    }
}
