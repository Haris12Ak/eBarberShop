﻿namespace eBarberShop.Model
{
    public class Recenzije
    {
        public int RecenzijeId { get; set; }
        public string Sadrzaj { get; set; }
        public double Ocjena { get; set; }
        public DateTime DatumObjave { get; set; }
        public int KorisnikId { get; set; }
        public Korisnici Korisnik { get; set; }

    }
}
