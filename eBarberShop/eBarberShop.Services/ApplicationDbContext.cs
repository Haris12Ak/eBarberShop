using eBarberShop.Services.Database;
using eBarberShop.Services.Helper;
using Microsoft.EntityFrameworkCore;

namespace eBarberShop.Services
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options)
        {

        }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            base.OnConfiguring(optionsBuilder);
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Drzava>()
                .HasData(
                new Drzava { DrzavaId = 1, Naziv = "Bosna i Hercegovina" },
                new Drzava { DrzavaId = 2, Naziv = "Hrvatska" },
                new Drzava { DrzavaId = 3, Naziv = "Njemacka" }
                );

            modelBuilder.Entity<Grad>()
                .HasData(
                 new Grad { GradId = 1, Naziv = "Fojnica", Opis = "Fojnica", DrzavaId = 1 },
                 new Grad { GradId = 2, Naziv = "Kiseljak", Opis = "Kiseljak", DrzavaId = 1 },
                 new Grad { GradId = 3, Naziv = "Zagreb", Opis = "Zagreb", DrzavaId = 2 },
                 new Grad { GradId = 4, Naziv = "Zenica", Opis = "Zenica", DrzavaId = 1 },
                 new Grad { GradId = 5, Naziv = "Berlin", Opis = "Berlin", DrzavaId = 3 },
                 new Grad { GradId = 6, Naziv = "Munchen", Opis = "Munchen", DrzavaId = 3 },
                 new Grad { GradId = 7, Naziv = "Mostar", Opis = "Mostar", DrzavaId = 1 },
                 new Grad { GradId = 8, Naziv = "Sarajevo", Opis = "Sarajevo", DrzavaId = 1 }
                );

            modelBuilder.Entity<Uloge>()
                .HasData(
                new Uloge { UlogeId = 1, Naziv = "Administrator", Opis = "administrator" },
                new Uloge { UlogeId = 2, Naziv = "Uposlenik", Opis = "Uposlenik" },
                new Uloge { UlogeId = 3, Naziv = "Klijent", Opis = "Klijent" }
                );

            List<string> _salts = new List<string>();
            for (int i = 0; i < 4; i++)
            {
                _salts.Add(PasswordHelper.GenerateSalt());
            }

            modelBuilder.Entity<Korisnici>()
                .HasData(
                new Korisnici { KorisniciId = 1, Ime = "Admin", Prezime = "Admin", Email = "admin@gmail.com", Adresa = "ulica 11", BrojTelefona = "061/321-333", KorisnickoIme = "admin", LozinkaSalt = _salts[0], LozinkaHash = PasswordHelper.GenerateHash(_salts[0], "admin"), GradId = 8 },
                new Korisnici { KorisniciId = 2, Ime = "Uposlenik", Prezime = "Uposlenik", Email = "uposlenik@gmail.com", Adresa = "ulica 2", BrojTelefona = "061/000-333", KorisnickoIme = "uposlenik", LozinkaSalt = _salts[1], LozinkaHash = PasswordHelper.GenerateHash(_salts[1], "uposlenik"), GradId = 7 },
                new Korisnici { KorisniciId = 3, Ime = "Test", Prezime = "Test", Email = "test@gmail.com", Adresa = "ulica 3", BrojTelefona = "062/100-333", KorisnickoIme = "test", LozinkaSalt = _salts[2], LozinkaHash = PasswordHelper.GenerateHash(_salts[2], "test"), GradId = 4 },
                new Korisnici { KorisniciId = 4, Ime = "Klijent", Prezime = "Klijent", Email = "klijent@gmail.com", Adresa = "ulica 9", BrojTelefona = "062/130-398", KorisnickoIme = "klijent", LozinkaSalt = _salts[3], LozinkaHash = PasswordHelper.GenerateHash(_salts[3], "klijent"), GradId = 4 }
                );

            modelBuilder.Entity<KorisniciUloge>()
                .HasData(
                new KorisniciUloge { KorisniciUlogeId = 1, KorisnikId = 1, UlogaId = 1, DatumIzmjene = DateTime.Now },
                new KorisniciUloge { KorisniciUlogeId = 2, KorisnikId = 2, UlogaId = 2, DatumIzmjene = DateTime.Now },
                new KorisniciUloge { KorisniciUlogeId = 3, KorisnikId = 3, UlogaId = 3, DatumIzmjene = DateTime.Now },
                new KorisniciUloge { KorisniciUlogeId = 4, KorisnikId = 4, UlogaId = 3, DatumIzmjene = DateTime.Now }
                );


            modelBuilder.Entity<Novosti>()
                .HasData(
                new Novosti { NovostiId = 1, Naslov = "Novi trendovi u frizurama", Sadrzaj = "Osvježite svoj izgled uz najnovije frizure koje su hit ove sezone! Naši stručnjaci su u toku sa najnovijim trendovima, stoga posjetite naš salon i otkrijte kako možete osvježiti svoj stil", DatumObjave = DateTime.Now, KorisnikId = 1 },
                new Novosti { NovostiId = 2, Naslov = "Posebna ponuda za bojanje kose", Sadrzaj = "Vrijeme je za promjenu boje! U narednom mjesecu nudimo posebnu ponudu na usluge bojanja kose. Bez obzira želite li se osvježiti ili potpuno transformisati, naši stručnjaci će vam pomoći postići savršen izgled", DatumObjave = DateTime.Now, KorisnikId = 1 },
                new Novosti { NovostiId = 3, Naslov = "Savjetovanje sa stilistom", Sadrzaj = "Želite li promjeniti frizuru, ali niste sigurni koji stil bi vam najbolje odgovarao? Zakažite savjetovanje sa našim stilistom koji će vam pomoći odabrati frizuru koja će najbolje istaći vaše karakteristike i stil", DatumObjave = DateTime.Now, KorisnikId = 1 }
                );

            modelBuilder.Entity<Recenzije>()
                .HasData(
                new Recenzije { RecenzijeId = 1, Ocjena = 5, Sadrzaj = "Posjetio sam ovaj salon prvi put, i moram priznati da sam bio zadovoljan. Atmosfera je opuštajuća, a osoblje je bilo veoma prijateljsko. Frizerka je imala odlične sugestije i savjete za negu kose. Sve preporuke!", DatumObjave = DateTime.Now, KorisnikId = 3 },
                new Recenzije { RecenzijeId = 2, Ocjena = 4, Sadrzaj = "Odličan salon, vrlo moderno uređen. Osoblje je veoma ljubazno i usluga je bila vrhunska. Moj frizer je bio veoma stručan i posvetio se svakom detalju. Jedini razlog zašto ne dajem pet zvjezdica je cijena koja je bila malo viša nego što sam očekivao, ali kvalitet je definitivno bio tu.", DatumObjave = DateTime.Now, KorisnikId = 4 }
                );

            modelBuilder.Entity<Uposlenik>()
                .HasData(
                new Uposlenik { UposlenikId = 1, Ime = "Uposlenik_1", Prezime = "Uposlenik_1", Adresa = "ulica 123", Email = "uposlenik_1@gmail.com", KontaktTelefon = "060/357-113" },
                new Uposlenik { UposlenikId = 2, Ime = "Uposlenik_2", Prezime = "Uposlenik_2", Adresa = "ulica 3", Email = "uposlenik_2@gmail.com", KontaktTelefon = "060/013-123" },
                new Uposlenik { UposlenikId = 3, Ime = "Uposlenik_3", Prezime = "Uposlenik_3", Adresa = "ulica 38", Email = "uposlenik_3@gmail.com", KontaktTelefon = "063/025-143" },
                new Uposlenik { UposlenikId = 4, Ime = "Uposlenik_4", Prezime = "Uposlenik_4", Adresa = "ulica 8", Email = "uposlenik_4@gmail.com", KontaktTelefon = "063/098-563" }
                );

            modelBuilder.Entity<Ocjene>()
                .HasData(
                new Ocjene { Id = 1, Datum = DateTime.Now, Ocjena = 5, UposlenikId = 1, KorisnikId = 1, },
                new Ocjene { Id = 2, Datum = DateTime.Now, Ocjena = 5, UposlenikId = 2, KorisnikId = 2, },
                new Ocjene { Id = 3, Datum = DateTime.Now, Ocjena = 5, UposlenikId = 3, KorisnikId = 3, },
                new Ocjene { Id = 4, Datum = DateTime.Now, Ocjena = 5, UposlenikId = 4, KorisnikId = 4, }
                );

            modelBuilder.Entity<Usluga>()
                .HasData(
                new Usluga { UslugaId = 1, Naziv = "Sisanje i oblikovanje", Cijena = 10, Trajanje = 15 },
                new Usluga { UslugaId = 2, Naziv = "Bojanje kose", Cijena = 30, Trajanje = 45 },
                new Usluga { UslugaId = 3, Naziv = "Feniranje i stilizovanje", Cijena = 15, Trajanje = 30 },
                new Usluga { UslugaId = 4, Naziv = "Permanente i trajno oblikovanje", Cijena = 50, Trajanje = 60 }
                );

            modelBuilder.Entity<Rezervacija>()
                .HasData(
                new Rezervacija { RezervacijaId = 1, Datum = new DateTime(2024, 1, 5, 0, 0, 0), Vrijeme = new DateTime(2024, 1, 5, 9, 30, 0), KorisnikId = 3, UposlenikId = 1, UslugaId = 1 },
                new Rezervacija { RezervacijaId = 2, Datum = new DateTime(2024, 1, 5, 0, 0, 0), Vrijeme = new DateTime(2024, 1, 5, 10, 15, 0), KorisnikId = 4, UposlenikId = 1, UslugaId = 2 },
                new Rezervacija { RezervacijaId = 3, Datum = new DateTime(2024, 1, 6, 0, 0, 0), Vrijeme = new DateTime(2024, 1, 6, 9, 0, 0), KorisnikId = 3, UposlenikId = 2, UslugaId = 1 },
                new Rezervacija { RezervacijaId = 4, Datum = new DateTime(2024, 1, 6, 0, 0, 0), Vrijeme = new DateTime(2024, 1, 6, 11, 30, 0), KorisnikId = 4, UposlenikId = 2, UslugaId = 2 }
                );

            modelBuilder.Entity<VrsteProizvoda>()
                .HasData(
                new VrsteProizvoda { VrsteProizvodaId = 1, Naziv = "Sampon", Opis = "Samponi prilagodeni razlicitim tipovima kose" },
                new VrsteProizvoda { VrsteProizvodaId = 2, Naziv = "Regemerator", Opis = "Regeneratori za njegu i hidrataciju kose" },
                new VrsteProizvoda { VrsteProizvodaId = 3, Naziv = "Gel", Opis = "Gelovi za oblikovanje kose" },
                new VrsteProizvoda { VrsteProizvodaId = 4, Naziv = "Vosak", Opis = "Vosak za oblikovanje kose" },
                new VrsteProizvoda { VrsteProizvodaId = 5, Naziv = "Boje", Opis = "Profesionalne boje za kosu u različitim nijansama" }
                );

            modelBuilder.Entity<Proizvodi>()
                .HasData(
                new Proizvodi { ProizvodiId = 1, Cijena = 8, Naziv = "Head & shoulders", Sifra = "0001", VrstaProizvodaId = 1 },
                new Proizvodi { ProizvodiId = 2, Cijena = 9.5m, Naziv = "Garnier", Sifra = "0002", VrstaProizvodaId = 1 },
                new Proizvodi { ProizvodiId = 3, Cijena = 5.5m, Naziv = "Balea", Sifra = "0003", VrstaProizvodaId = 2 },
                new Proizvodi { ProizvodiId = 4, Cijena = 7, Naziv = "Taft", Sifra = "0004", VrstaProizvodaId = 3 },
                new Proizvodi { ProizvodiId = 5, Cijena = 6.5m, Naziv = "got2b", Sifra = "0005", VrstaProizvodaId = 3 },
                new Proizvodi { ProizvodiId = 6, Cijena = 6, Naziv = "taft POWER", Sifra = "0007", VrstaProizvodaId = 4 },
                new Proizvodi { ProizvodiId = 7, Cijena = 7.5m, Naziv = "Garnier Color Naturals", Sifra = "0008", VrstaProizvodaId = 5 },
                new Proizvodi { ProizvodiId = 8, Cijena = 8, Naziv = "Loreal", Sifra = "0008", VrstaProizvodaId = 5 }
                );

            modelBuilder.Entity<Narudzbe>()
                .HasData(
                new Narudzbe { NarudzbeId = 1, BrojNarudzbe = "000001", DatumNarudzbe = DateTime.Now, UkupanIznos = 8, Status = true, Otkazano = false, KorisnikId = 3 },
                new Narudzbe { NarudzbeId = 2, BrojNarudzbe = "000002", DatumNarudzbe = DateTime.Now, UkupanIznos = 16, Status = true, Otkazano = false, KorisnikId = 3 },
                new Narudzbe { NarudzbeId = 3, BrojNarudzbe = "000003", DatumNarudzbe = DateTime.Now, UkupanIznos = 6, Status = true, Otkazano = false, KorisnikId = 4 },
                new Narudzbe { NarudzbeId = 4, BrojNarudzbe = "000004", DatumNarudzbe = DateTime.Now, UkupanIznos = 7.5m, Status = true, Otkazano = false, KorisnikId = 4 }
                );

            modelBuilder.Entity<NarudzbeDetalji>()
                .HasData(
                new NarudzbeDetalji { NarudzbeDetaljiId = 1, Kolicina = 1, NarudzbaId = 1, ProizvodId = 1 },
                new NarudzbeDetalji { NarudzbeDetaljiId = 2, Kolicina = 2, NarudzbaId = 2, ProizvodId = 1 },
                new NarudzbeDetalji { NarudzbeDetaljiId = 3, Kolicina = 1, NarudzbaId = 3, ProizvodId = 6 },
                new NarudzbeDetalji { NarudzbeDetaljiId = 4, Kolicina = 1, NarudzbaId = 4, ProizvodId = 7 }
                );

            base.OnModelCreating(modelBuilder);
        }

        public virtual DbSet<Drzava> Drzava { get; set; }
        public virtual DbSet<Grad> Grad { get; set; }
        public virtual DbSet<Korisnici> Korisnici { get; set; }
        public virtual DbSet<KorisniciUloge> KorisniciUloge { get; set; }
        public virtual DbSet<Uloge> Uloge { get; set; }
        public virtual DbSet<Narudzbe> Narudzbe { get; set; }
        public virtual DbSet<NarudzbeDetalji> NarudzbeDetalji { get; set; }
        public virtual DbSet<PaymentDetail> PaymentDetail { get; set; }
        public virtual DbSet<Proizvodi> Proizvodi { get; set; }
        public virtual DbSet<VrsteProizvoda> VrsteProizvoda { get; set; }
        public virtual DbSet<Rezervacija> Rezervacija { get; set; }
        public virtual DbSet<Slike> Slike { get; set; }
        public virtual DbSet<SlikeUsluge> SlikeUsluge { get; set; }
        public virtual DbSet<Uposlenik> Uposlenik { get; set; }
        public virtual DbSet<Usluga> Usluga { get; set; }
        public virtual DbSet<Novosti> Novosti { get; set; }
        public virtual DbSet<Recenzije> Recenzije { get; set; }
        public virtual DbSet<Ocjene> Ocjene { get; set; }
    }
}
