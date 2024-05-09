using eBarberShop.Services.Database;
using Microsoft.EntityFrameworkCore;

namespace eBarberShop.Services
{
    public partial class ApplicationDbContext : DbContext
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
            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);


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
