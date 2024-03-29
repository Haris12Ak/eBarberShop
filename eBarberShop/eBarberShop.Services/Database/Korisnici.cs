namespace eBarberShop.Services.Database
{
    public partial class Korisnici
    {
        public int KorisniciId { get; set; }
        public string Ime { get; set; }
        public string Prezime { get; set; }
        public string Email { get; set; }
        public string? Adresa { get; set; }
        public string? BrojTelefona { get; set; }
        public string KorisnickoIme { get; set; }
        public string LozinkaHash { get; set; }
        public string LozinkaSalt { get; set; }
        public bool? Status { get; set; }
        public byte[]? Slika { get; set; }
        public int GradId { get; set; }

        public virtual Grad Grad { get; set; }

        public virtual ICollection<KorisniciUloge> KorisniciUloge { get; set; } = new List<KorisniciUloge>();
        public virtual ICollection<Narudzbe> Narudzbe { get; set; } = new List<Narudzbe>();
        public virtual ICollection<Rezervacija> Rezervacije { get; set; } = new List<Rezervacija>();
        public virtual ICollection<Novosti> Novosti { get; set; } = new List<Novosti>();
        public virtual ICollection<Recenzije> Recenzije { get; set; } = new List<Recenzije>();
        public virtual ICollection<Ocjene> Ocjene { get; set; } = new List<Ocjene>();
    }
}
