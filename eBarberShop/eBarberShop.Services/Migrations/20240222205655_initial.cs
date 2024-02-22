using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace eBarberShop.Services.Migrations
{
    /// <inheritdoc />
    public partial class initial : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Drzava",
                columns: table => new
                {
                    DrzavaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Drzava", x => x.DrzavaId);
                });

            migrationBuilder.CreateTable(
                name: "Slike",
                columns: table => new
                {
                    SlikeId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Opis = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Slika = table.Column<byte[]>(type: "varbinary(max)", nullable: false),
                    DatumPostavljanja = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Slike", x => x.SlikeId);
                });

            migrationBuilder.CreateTable(
                name: "Uloge",
                columns: table => new
                {
                    UlogeId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Opis = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Uloge", x => x.UlogeId);
                });

            migrationBuilder.CreateTable(
                name: "Uposlenik",
                columns: table => new
                {
                    UposlenikId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Ime = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Prezime = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    KontaktTelefon = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Email = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Adresa = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Uposlenik", x => x.UposlenikId);
                });

            migrationBuilder.CreateTable(
                name: "Usluga",
                columns: table => new
                {
                    UslugaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Opis = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Cijena = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    Trajanje = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Usluga", x => x.UslugaId);
                });

            migrationBuilder.CreateTable(
                name: "VrsteProizvoda",
                columns: table => new
                {
                    VrsteProizvodaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Opis = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_VrsteProizvoda", x => x.VrsteProizvodaId);
                });

            migrationBuilder.CreateTable(
                name: "Grad",
                columns: table => new
                {
                    GradId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    DrzavaId = table.Column<int>(type: "int", nullable: false),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Opis = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Grad", x => x.GradId);
                    table.ForeignKey(
                        name: "FK_Grad_Drzava_DrzavaId",
                        column: x => x.DrzavaId,
                        principalTable: "Drzava",
                        principalColumn: "DrzavaId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "SlikeUsluge",
                columns: table => new
                {
                    SlikeUslugeId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    UslugaId = table.Column<int>(type: "int", nullable: false),
                    SlikaId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_SlikeUsluge", x => x.SlikeUslugeId);
                    table.ForeignKey(
                        name: "FK_SlikeUsluge_Slike_SlikaId",
                        column: x => x.SlikaId,
                        principalTable: "Slike",
                        principalColumn: "SlikeId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_SlikeUsluge_Usluga_UslugaId",
                        column: x => x.UslugaId,
                        principalTable: "Usluga",
                        principalColumn: "UslugaId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Proizvodi",
                columns: table => new
                {
                    ProizvodiId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Cijena = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Sifra = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Opis = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Slika = table.Column<byte[]>(type: "varbinary(max)", nullable: true),
                    Status = table.Column<bool>(type: "bit", nullable: true),
                    VrstaProizvodaId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Proizvodi", x => x.ProizvodiId);
                    table.ForeignKey(
                        name: "FK_Proizvodi_VrsteProizvoda_VrstaProizvodaId",
                        column: x => x.VrstaProizvodaId,
                        principalTable: "VrsteProizvoda",
                        principalColumn: "VrsteProizvodaId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Korisnici",
                columns: table => new
                {
                    KorisniciId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Ime = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Prezime = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Email = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Adresa = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    BrojTelefona = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    KorisnickoIme = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    LozinkaHash = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    LozinkaSalt = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Status = table.Column<bool>(type: "bit", nullable: true),
                    Slika = table.Column<byte[]>(type: "varbinary(max)", nullable: true),
                    GradId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Korisnici", x => x.KorisniciId);
                    table.ForeignKey(
                        name: "FK_Korisnici_Grad_GradId",
                        column: x => x.GradId,
                        principalTable: "Grad",
                        principalColumn: "GradId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "KorisniciUloge",
                columns: table => new
                {
                    KorisniciUlogeId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    KorisnikId = table.Column<int>(type: "int", nullable: false),
                    UlogaId = table.Column<int>(type: "int", nullable: false),
                    DatumIzmjene = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_KorisniciUloge", x => x.KorisniciUlogeId);
                    table.ForeignKey(
                        name: "FK_KorisniciUloge_Korisnici_KorisnikId",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnici",
                        principalColumn: "KorisniciId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_KorisniciUloge_Uloge_UlogaId",
                        column: x => x.UlogaId,
                        principalTable: "Uloge",
                        principalColumn: "UlogeId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Kosarica",
                columns: table => new
                {
                    KosaricaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Kolicina = table.Column<int>(type: "int", nullable: false),
                    UkupanIznos = table.Column<decimal>(type: "decimal(18,2)", nullable: true),
                    KorisnikId = table.Column<int>(type: "int", nullable: false),
                    ProizvodId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Kosarica", x => x.KosaricaId);
                    table.ForeignKey(
                        name: "FK_Kosarica_Korisnici_KorisnikId",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnici",
                        principalColumn: "KorisniciId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Kosarica_Proizvodi_ProizvodId",
                        column: x => x.ProizvodId,
                        principalTable: "Proizvodi",
                        principalColumn: "ProizvodiId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Narudzbe",
                columns: table => new
                {
                    NarudzbeId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    BrojNarudzbe = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    DatumNarudzbe = table.Column<DateTime>(type: "datetime2", nullable: false),
                    UkupanIznos = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    Status = table.Column<bool>(type: "bit", nullable: false),
                    Otkazano = table.Column<bool>(type: "bit", nullable: true),
                    KorisnikId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Narudzbe", x => x.NarudzbeId);
                    table.ForeignKey(
                        name: "FK_Narudzbe_Korisnici_KorisnikId",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnici",
                        principalColumn: "KorisniciId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Novosti",
                columns: table => new
                {
                    NovostiId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naslov = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Sadrzaj = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    DatumObjave = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Slika = table.Column<byte[]>(type: "varbinary(max)", nullable: true),
                    KorisnikId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Novosti", x => x.NovostiId);
                    table.ForeignKey(
                        name: "FK_Novosti_Korisnici_KorisnikId",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnici",
                        principalColumn: "KorisniciId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Recenzije",
                columns: table => new
                {
                    RecenzijeId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Sadrzaj = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Ocjena = table.Column<int>(type: "int", nullable: false),
                    DatumObjave = table.Column<DateTime>(type: "datetime2", nullable: false),
                    KorisnikId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Recenzije", x => x.RecenzijeId);
                    table.ForeignKey(
                        name: "FK_Recenzije_Korisnici_KorisnikId",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnici",
                        principalColumn: "KorisniciId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Rezervacija",
                columns: table => new
                {
                    RezervacijaId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Datum = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Vrijeme = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Status = table.Column<bool>(type: "bit", nullable: true),
                    KorisnikId = table.Column<int>(type: "int", nullable: false),
                    UposlenikId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Rezervacija", x => x.RezervacijaId);
                    table.ForeignKey(
                        name: "FK_Rezervacija_Korisnici_KorisnikId",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnici",
                        principalColumn: "KorisniciId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Rezervacija_Uposlenik_UposlenikId",
                        column: x => x.UposlenikId,
                        principalTable: "Uposlenik",
                        principalColumn: "UposlenikId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "NarudzbeDetalji",
                columns: table => new
                {
                    NarudzbeDetaljiId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Kolicina = table.Column<int>(type: "int", nullable: false),
                    NarudzbaId = table.Column<int>(type: "int", nullable: false),
                    ProizvodId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_NarudzbeDetalji", x => x.NarudzbeDetaljiId);
                    table.ForeignKey(
                        name: "FK_NarudzbeDetalji_Narudzbe_NarudzbaId",
                        column: x => x.NarudzbaId,
                        principalTable: "Narudzbe",
                        principalColumn: "NarudzbeId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_NarudzbeDetalji_Proizvodi_ProizvodId",
                        column: x => x.ProizvodId,
                        principalTable: "Proizvodi",
                        principalColumn: "ProizvodiId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Placanje",
                columns: table => new
                {
                    PlacanjeId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    DatumUplate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Iznos = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    Status = table.Column<bool>(type: "bit", nullable: true),
                    NarudzbaId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Placanje", x => x.PlacanjeId);
                    table.ForeignKey(
                        name: "FK_Placanje_Narudzbe_NarudzbaId",
                        column: x => x.NarudzbaId,
                        principalTable: "Narudzbe",
                        principalColumn: "NarudzbeId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "RezervacijaUsluge",
                columns: table => new
                {
                    RezervacijaUslugeId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    RezervacijaId = table.Column<int>(type: "int", nullable: false),
                    UslugaId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_RezervacijaUsluge", x => x.RezervacijaUslugeId);
                    table.ForeignKey(
                        name: "FK_RezervacijaUsluge_Rezervacija_RezervacijaId",
                        column: x => x.RezervacijaId,
                        principalTable: "Rezervacija",
                        principalColumn: "RezervacijaId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_RezervacijaUsluge_Usluga_UslugaId",
                        column: x => x.UslugaId,
                        principalTable: "Usluga",
                        principalColumn: "UslugaId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.InsertData(
                table: "Drzava",
                columns: new[] { "DrzavaId", "Naziv" },
                values: new object[,]
                {
                    { 1, "Bosna i Hercegovina" },
                    { 2, "Hrvatska" },
                    { 3, "Njemacka" }
                });

            migrationBuilder.InsertData(
                table: "Uloge",
                columns: new[] { "UlogeId", "Naziv", "Opis" },
                values: new object[,]
                {
                    { 1, "Administrator", "administrator" },
                    { 2, "Uposlenik", "Uposlenik" },
                    { 3, "Klijent", "Klijent" }
                });

            migrationBuilder.InsertData(
                table: "Uposlenik",
                columns: new[] { "UposlenikId", "Adresa", "Email", "Ime", "KontaktTelefon", "Prezime" },
                values: new object[,]
                {
                    { 1, "ulica 123", "uposlenik_1@gmail.com", "Uposlenik_1", "060/357-113", "Uposlenik_1" },
                    { 2, "ulica 3", "uposlenik_2@gmail.com", "Uposlenik_2", "060/013-123", "Uposlenik_2" },
                    { 3, "ulica 38", "uposlenik_3@gmail.com", "Uposlenik_3", "063/025-143", "Uposlenik_3" },
                    { 4, "ulica 8", "uposlenik_4@gmail.com", "Uposlenik_4", "063/098-563", "Uposlenik_4" }
                });

            migrationBuilder.InsertData(
                table: "Usluga",
                columns: new[] { "UslugaId", "Cijena", "Naziv", "Opis", "Trajanje" },
                values: new object[,]
                {
                    { 1, 10m, "Sisanje i oblikovanje", null, 15 },
                    { 2, 30m, "Bojanje kose", null, 45 },
                    { 3, 15m, "Feniranje i stilizovanje", null, 30 },
                    { 4, 50m, "Permanente i trajno oblikovanje", null, 60 }
                });

            migrationBuilder.InsertData(
                table: "VrsteProizvoda",
                columns: new[] { "VrsteProizvodaId", "Naziv", "Opis" },
                values: new object[,]
                {
                    { 1, "Sampon", "Samponi prilagodeni razlicitim tipovima kose" },
                    { 2, "Regemerator", "Regeneratori za njegu i hidrataciju kose" },
                    { 3, "Gel", "Gelovi za oblikovanje kose" },
                    { 4, "Vosak", "Vosak za oblikovanje kose" },
                    { 5, "Boje", "Profesionalne boje za kosu u različitim nijansama" }
                });

            migrationBuilder.InsertData(
                table: "Grad",
                columns: new[] { "GradId", "DrzavaId", "Naziv", "Opis" },
                values: new object[,]
                {
                    { 1, 1, "Fojnica", "Fojnica" },
                    { 2, 1, "Kiseljak", "Kiseljak" },
                    { 3, 2, "Zagreb", "Zagreb" },
                    { 4, 1, "Zenica", "Zenica" },
                    { 5, 3, "Berlin", "Berlin" },
                    { 6, 3, "Munchen", "Munchen" },
                    { 7, 1, "Mostar", "Mostar" },
                    { 8, 1, "Sarajevo", "Sarajevo" }
                });

            migrationBuilder.InsertData(
                table: "Proizvodi",
                columns: new[] { "ProizvodiId", "Cijena", "Naziv", "Opis", "Sifra", "Slika", "Status", "VrstaProizvodaId" },
                values: new object[,]
                {
                    { 1, 8m, "Head & shoulders", null, "0001", null, null, 1 },
                    { 2, 9.5m, "Garnier", null, "0002", null, null, 1 },
                    { 3, 5.5m, "Balea", null, "0003", null, null, 2 },
                    { 4, 7m, "Taft", null, "0004", null, null, 3 },
                    { 5, 6.5m, "got2b", null, "0005", null, null, 3 },
                    { 6, 6m, "taft POWER", null, "0007", null, null, 4 },
                    { 7, 7.5m, "Garnier Color Naturals", null, "0008", null, null, 5 },
                    { 8, 8m, "Loreal", null, "0008", null, null, 5 }
                });

            migrationBuilder.InsertData(
                table: "Korisnici",
                columns: new[] { "KorisniciId", "Adresa", "BrojTelefona", "Email", "GradId", "Ime", "KorisnickoIme", "LozinkaHash", "LozinkaSalt", "Prezime", "Slika", "Status" },
                values: new object[,]
                {
                    { 1, "ulica 11", "061/321-333", "admin@gmail.com", 8, "Admin", "admin", "atJ9u3e7ql1Fupbm/Qiu9wOmsHA=", "EVgU2BPeThoDDheO3xwkxA==", "Admin", null, null },
                    { 2, "ulica 2", "061/000-333", "uposlenik@gmail.com", 7, "Uposlenik", "uposlenik", "UU4+tHWzQwSaatA/f23WznbyvX0=", "XXh7gVQ6JlhMruLRUCPscg==", "Uposlenik", null, null },
                    { 3, "ulica 3", "062/100-333", "test@gmail.com", 4, "Test", "test", "SSCet0mbf5AKKV6gnqtUZacqQhU=", "hLljAq4KB58HLJ3pXgbt9Q==", "Test", null, null },
                    { 4, "ulica 9", "062/130-398", "klijent@gmail.com", 4, "Klijent", "klijent", "C/4M8AXV2R6w3TQNz7DMXU4RaQo=", "FCvcNESfV3xCUA2pbIvodg==", "Klijent", null, null }
                });

            migrationBuilder.InsertData(
                table: "KorisniciUloge",
                columns: new[] { "KorisniciUlogeId", "DatumIzmjene", "KorisnikId", "UlogaId" },
                values: new object[,]
                {
                    { 1, new DateTime(2024, 2, 22, 21, 56, 55, 134, DateTimeKind.Local).AddTicks(3903), 1, 1 },
                    { 2, new DateTime(2024, 2, 22, 21, 56, 55, 134, DateTimeKind.Local).AddTicks(3952), 2, 2 },
                    { 3, new DateTime(2024, 2, 22, 21, 56, 55, 134, DateTimeKind.Local).AddTicks(3955), 3, 3 },
                    { 4, new DateTime(2024, 2, 22, 21, 56, 55, 134, DateTimeKind.Local).AddTicks(3958), 4, 3 }
                });

            migrationBuilder.InsertData(
                table: "Kosarica",
                columns: new[] { "KosaricaId", "Kolicina", "KorisnikId", "ProizvodId", "UkupanIznos" },
                values: new object[,]
                {
                    { 1, 1, 3, 1, 8m },
                    { 2, 2, 3, 1, 16m },
                    { 3, 1, 4, 6, 6m },
                    { 4, 1, 4, 7, 7.5m }
                });

            migrationBuilder.InsertData(
                table: "Narudzbe",
                columns: new[] { "NarudzbeId", "BrojNarudzbe", "DatumNarudzbe", "KorisnikId", "Otkazano", "Status", "UkupanIznos" },
                values: new object[,]
                {
                    { 1, "000001", new DateTime(2024, 2, 22, 21, 56, 55, 134, DateTimeKind.Local).AddTicks(4266), 3, false, true, 8m },
                    { 2, "000002", new DateTime(2024, 2, 22, 21, 56, 55, 134, DateTimeKind.Local).AddTicks(4272), 3, false, true, 16m },
                    { 3, "000003", new DateTime(2024, 2, 22, 21, 56, 55, 134, DateTimeKind.Local).AddTicks(4275), 4, false, true, 6m },
                    { 4, "000004", new DateTime(2024, 2, 22, 21, 56, 55, 134, DateTimeKind.Local).AddTicks(4279), 4, false, true, 7.5m }
                });

            migrationBuilder.InsertData(
                table: "Novosti",
                columns: new[] { "NovostiId", "DatumObjave", "KorisnikId", "Naslov", "Sadrzaj", "Slika" },
                values: new object[,]
                {
                    { 1, new DateTime(2024, 2, 22, 21, 56, 55, 134, DateTimeKind.Local).AddTicks(3978), 1, "Novi trendovi u frizurama", "Osvježite svoj izgled uz najnovije frizure koje su hit ove sezone! Naši stručnjaci su u toku sa najnovijim trendovima, stoga posjetite naš salon i otkrijte kako možete osvježiti svoj stil", null },
                    { 2, new DateTime(2024, 2, 22, 21, 56, 55, 134, DateTimeKind.Local).AddTicks(3982), 1, "Posebna ponuda za bojanje kose", "Vrijeme je za promjenu boje! U narednom mjesecu nudimo posebnu ponudu na usluge bojanja kose. Bez obzira želite li se osvježiti ili potpuno transformisati, naši stručnjaci će vam pomoći postići savršen izgled", null },
                    { 3, new DateTime(2024, 2, 22, 21, 56, 55, 134, DateTimeKind.Local).AddTicks(3985), 1, "Savjetovanje sa stilistom", "Želite li promjeniti frizuru, ali niste sigurni koji stil bi vam najbolje odgovarao? Zakažite savjetovanje sa našim stilistom koji će vam pomoći odabrati frizuru koja će najbolje istaći vaše karakteristike i stil", null }
                });

            migrationBuilder.InsertData(
                table: "Recenzije",
                columns: new[] { "RecenzijeId", "DatumObjave", "KorisnikId", "Ocjena", "Sadrzaj" },
                values: new object[,]
                {
                    { 1, new DateTime(2024, 2, 22, 21, 56, 55, 134, DateTimeKind.Local).AddTicks(4005), 3, 5, "Posjetio sam ovaj salon prvi put, i moram priznati da sam bio zadovoljan. Atmosfera je opuštajuća, a osoblje je bilo veoma prijateljsko. Frizerka je imala odlične sugestije i savjete za negu kose. Sve preporuke!" },
                    { 2, new DateTime(2024, 2, 22, 21, 56, 55, 134, DateTimeKind.Local).AddTicks(4009), 4, 4, "Odličan salon, vrlo moderno uređen. Osoblje je veoma ljubazno i usluga je bila vrhunska. Moj frizer je bio veoma stručan i posvetio se svakom detalju. Jedini razlog zašto ne dajem pet zvjezdica je cijena koja je bila malo viša nego što sam očekivao, ali kvalitet je definitivno bio tu." }
                });

            migrationBuilder.InsertData(
                table: "Rezervacija",
                columns: new[] { "RezervacijaId", "Datum", "KorisnikId", "Status", "UposlenikId", "Vrijeme" },
                values: new object[,]
                {
                    { 1, new DateTime(2024, 1, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), 3, null, 1, new DateTime(2024, 1, 5, 9, 30, 0, 0, DateTimeKind.Unspecified) },
                    { 2, new DateTime(2024, 1, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), 4, null, 1, new DateTime(2024, 1, 5, 10, 15, 0, 0, DateTimeKind.Unspecified) },
                    { 3, new DateTime(2024, 1, 6, 0, 0, 0, 0, DateTimeKind.Unspecified), 3, null, 2, new DateTime(2024, 1, 6, 9, 0, 0, 0, DateTimeKind.Unspecified) },
                    { 4, new DateTime(2024, 1, 6, 0, 0, 0, 0, DateTimeKind.Unspecified), 4, null, 2, new DateTime(2024, 1, 6, 11, 30, 0, 0, DateTimeKind.Unspecified) }
                });

            migrationBuilder.InsertData(
                table: "NarudzbeDetalji",
                columns: new[] { "NarudzbeDetaljiId", "Kolicina", "NarudzbaId", "ProizvodId" },
                values: new object[,]
                {
                    { 1, 1, 1, 1 },
                    { 2, 2, 2, 1 },
                    { 3, 1, 3, 6 },
                    { 4, 1, 4, 7 }
                });

            migrationBuilder.InsertData(
                table: "RezervacijaUsluge",
                columns: new[] { "RezervacijaUslugeId", "RezervacijaId", "UslugaId" },
                values: new object[,]
                {
                    { 1, 1, 1 },
                    { 2, 2, 2 },
                    { 3, 3, 4 },
                    { 4, 4, 3 }
                });

            migrationBuilder.CreateIndex(
                name: "IX_Grad_DrzavaId",
                table: "Grad",
                column: "DrzavaId");

            migrationBuilder.CreateIndex(
                name: "IX_Korisnici_GradId",
                table: "Korisnici",
                column: "GradId");

            migrationBuilder.CreateIndex(
                name: "IX_KorisniciUloge_KorisnikId",
                table: "KorisniciUloge",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_KorisniciUloge_UlogaId",
                table: "KorisniciUloge",
                column: "UlogaId");

            migrationBuilder.CreateIndex(
                name: "IX_Kosarica_KorisnikId",
                table: "Kosarica",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_Kosarica_ProizvodId",
                table: "Kosarica",
                column: "ProizvodId");

            migrationBuilder.CreateIndex(
                name: "IX_Narudzbe_KorisnikId",
                table: "Narudzbe",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_NarudzbeDetalji_NarudzbaId",
                table: "NarudzbeDetalji",
                column: "NarudzbaId");

            migrationBuilder.CreateIndex(
                name: "IX_NarudzbeDetalji_ProizvodId",
                table: "NarudzbeDetalji",
                column: "ProizvodId");

            migrationBuilder.CreateIndex(
                name: "IX_Novosti_KorisnikId",
                table: "Novosti",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_Placanje_NarudzbaId",
                table: "Placanje",
                column: "NarudzbaId");

            migrationBuilder.CreateIndex(
                name: "IX_Proizvodi_VrstaProizvodaId",
                table: "Proizvodi",
                column: "VrstaProizvodaId");

            migrationBuilder.CreateIndex(
                name: "IX_Recenzije_KorisnikId",
                table: "Recenzije",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_Rezervacija_KorisnikId",
                table: "Rezervacija",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_Rezervacija_UposlenikId",
                table: "Rezervacija",
                column: "UposlenikId");

            migrationBuilder.CreateIndex(
                name: "IX_RezervacijaUsluge_RezervacijaId",
                table: "RezervacijaUsluge",
                column: "RezervacijaId");

            migrationBuilder.CreateIndex(
                name: "IX_RezervacijaUsluge_UslugaId",
                table: "RezervacijaUsluge",
                column: "UslugaId");

            migrationBuilder.CreateIndex(
                name: "IX_SlikeUsluge_SlikaId",
                table: "SlikeUsluge",
                column: "SlikaId");

            migrationBuilder.CreateIndex(
                name: "IX_SlikeUsluge_UslugaId",
                table: "SlikeUsluge",
                column: "UslugaId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "KorisniciUloge");

            migrationBuilder.DropTable(
                name: "Kosarica");

            migrationBuilder.DropTable(
                name: "NarudzbeDetalji");

            migrationBuilder.DropTable(
                name: "Novosti");

            migrationBuilder.DropTable(
                name: "Placanje");

            migrationBuilder.DropTable(
                name: "Recenzije");

            migrationBuilder.DropTable(
                name: "RezervacijaUsluge");

            migrationBuilder.DropTable(
                name: "SlikeUsluge");

            migrationBuilder.DropTable(
                name: "Uloge");

            migrationBuilder.DropTable(
                name: "Proizvodi");

            migrationBuilder.DropTable(
                name: "Narudzbe");

            migrationBuilder.DropTable(
                name: "Rezervacija");

            migrationBuilder.DropTable(
                name: "Slike");

            migrationBuilder.DropTable(
                name: "Usluga");

            migrationBuilder.DropTable(
                name: "VrsteProizvoda");

            migrationBuilder.DropTable(
                name: "Korisnici");

            migrationBuilder.DropTable(
                name: "Uposlenik");

            migrationBuilder.DropTable(
                name: "Grad");

            migrationBuilder.DropTable(
                name: "Drzava");
        }
    }
}
