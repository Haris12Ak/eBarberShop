﻿namespace eBarberShop.Model.Requests
{
    public class RecenzijeUpdateRequest
    {
        public string Sadrzaj { get; set; }
        public double Ocjena { get; set; }
        public DateTime DatumObjave { get; set; }
        public int KorisnikId { get; set; }
    }
}
