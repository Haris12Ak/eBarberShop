namespace eBarberShop.Model
{
    public class TerminiKorisnikaInfo
    {
        public int RezervacijaId { get; set; }
        public DateTime Datum { get; set; }
        public DateTime Vrijeme { get; set; }
        public string NazivUsluge { get; set; }
        public bool IsAktivna { get; set; }
    }
}
