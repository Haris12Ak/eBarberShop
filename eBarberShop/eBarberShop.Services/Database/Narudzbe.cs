namespace eBarberShop.Services.Database
{
    public partial class Narudzbe
    {
        public int NarudzbeId { get; set; }
        public string BrojNarudzbe { get; set; }
        public DateTime DatumNarudzbe { get; set; }
        public decimal UkupanIznos { get; set; }
        public bool Status { get; set; }
        public bool? Otkazano { get; set; }
        public int KorisnikId { get; set; }

        public virtual Korisnici Korisnik { get; set; }

        public virtual ICollection<NarudzbeDetalji> NarudzbeDetalji { get; set; } = new List<NarudzbeDetalji>();
        public virtual ICollection<PaymentDetail> PaymentDetail { get; set; } = new List<PaymentDetail>();

    }
}
