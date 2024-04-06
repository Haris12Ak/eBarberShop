namespace eBarberShop.Model
{
    public class IzvjestajRezervacije
    {
        public int UkupnoRezervacija { get; set; }
        public int UkupnoAktivnihRezervacija { get; set; }
        public int UkupnoNeaktivnihRezervacija { get; set; }
        public decimal ZaradaPrethodnogDana { get; set; }
        public decimal ZaradaPrethodneSemice { get; set; }
        public decimal ZaradaPrethodnogMjeseca { get; set; }
        public int BrojRezervacijaPrethodnogDana { get; set; }
        public int BrojRezervacijaPrethodneSedmice { get; set; }
        public int BrojRezervacijaPrethodnogMjeseca { get; set; }
        public int BrojUsluga { get; set; }
        public string UposlenikSaNajviseRezervacija { get; set; }
        public string UslugaSaNajviseRezervacija { get; set; }
        public decimal UkupnaZarada { get; set; }
    }
}
