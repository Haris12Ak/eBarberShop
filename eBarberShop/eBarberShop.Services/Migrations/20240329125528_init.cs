using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace eBarberShop.Services.Migrations
{
    /// <inheritdoc />
    public partial class init : Migration
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
                    Slika = table.Column<byte[]>(type: "varbinary(max)", nullable: true),
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
                name: "Ocjene",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Datum = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Ocjena = table.Column<double>(type: "float", nullable: false),
                    Opis = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    UposlenikId = table.Column<int>(type: "int", nullable: false),
                    KorisnikId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Ocjene", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Ocjene_Korisnici_KorisnikId",
                        column: x => x.KorisnikId,
                        principalTable: "Korisnici",
                        principalColumn: "KorisniciId",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Ocjene_Uposlenik_UposlenikId",
                        column: x => x.UposlenikId,
                        principalTable: "Uposlenik",
                        principalColumn: "UposlenikId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Recenzije",
                columns: table => new
                {
                    RecenzijeId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Sadrzaj = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Ocjena = table.Column<double>(type: "float", nullable: false),
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
                    UposlenikId = table.Column<int>(type: "int", nullable: false),
                    UslugaId = table.Column<int>(type: "int", nullable: false)
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
                    table.ForeignKey(
                        name: "FK_Rezervacija_Usluga_UslugaId",
                        column: x => x.UslugaId,
                        principalTable: "Usluga",
                        principalColumn: "UslugaId",
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
                columns: new[] { "UslugaId", "Cijena", "Naziv", "Opis", "Slika", "Trajanje" },
                values: new object[,]
                {
                    { 1, 10m, "Sisanje i oblikovanje", null, null, 15 },
                    { 2, 30m, "Bojanje kose", null, null, 45 },
                    { 3, 15m, "Feniranje i stilizovanje", null, null, 30 },
                    { 4, 50m, "Permanente i trajno oblikovanje", null, null, 60 }
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
                    { 1, "ulica 11", "061/321-333", "admin@gmail.com", 8, "Admin", "admin", "MibXNNuTfcVDdn7azEUpufMXl6k=", "x9iF/LoRyj+HZVEufAHnhQ==", "Admin", null, null },
                    { 2, "ulica 2", "061/000-333", "uposlenik@gmail.com", 7, "Uposlenik", "uposlenik", "r9ZMv6KLPF5jxaHOQu1i0sC70zI=", "IODJ4cm5upvUKDD65Eu/Mg==", "Uposlenik", null, null },
                    { 3, "ulica 3", "062/100-333", "test@gmail.com", 4, "Test", "test", "3k1Kl7HncnEtc1ymP3PlQzvEYhA=", "JUFmi1KS3TQuf6PgOef7pA==", "Test", null, null },
                    { 4, "ulica 9", "062/130-398", "klijent@gmail.com", 4, "Klijent", "klijent", "ieXacih8ZJ1DjKNYLE4b4xzN7EA=", "QMBBpbVKJkqrq7mmF+LbqQ==", "Klijent", null, null }
                });

            migrationBuilder.InsertData(
                table: "KorisniciUloge",
                columns: new[] { "KorisniciUlogeId", "DatumIzmjene", "KorisnikId", "UlogaId" },
                values: new object[,]
                {
                    { 1, new DateTime(2024, 3, 29, 13, 55, 28, 192, DateTimeKind.Local).AddTicks(5684), 1, 1 },
                    { 2, new DateTime(2024, 3, 29, 13, 55, 28, 192, DateTimeKind.Local).AddTicks(5733), 2, 2 },
                    { 3, new DateTime(2024, 3, 29, 13, 55, 28, 192, DateTimeKind.Local).AddTicks(5736), 3, 3 },
                    { 4, new DateTime(2024, 3, 29, 13, 55, 28, 192, DateTimeKind.Local).AddTicks(5739), 4, 3 }
                });

            migrationBuilder.InsertData(
                table: "Narudzbe",
                columns: new[] { "NarudzbeId", "BrojNarudzbe", "DatumNarudzbe", "KorisnikId", "Otkazano", "Status", "UkupanIznos" },
                values: new object[,]
                {
                    { 1, "000001", new DateTime(2024, 3, 29, 13, 55, 28, 192, DateTimeKind.Local).AddTicks(6037), 3, false, true, 8m },
                    { 2, "000002", new DateTime(2024, 3, 29, 13, 55, 28, 192, DateTimeKind.Local).AddTicks(6042), 3, false, true, 16m },
                    { 3, "000003", new DateTime(2024, 3, 29, 13, 55, 28, 192, DateTimeKind.Local).AddTicks(6046), 4, false, true, 6m },
                    { 4, "000004", new DateTime(2024, 3, 29, 13, 55, 28, 192, DateTimeKind.Local).AddTicks(6050), 4, false, true, 7.5m }
                });

            migrationBuilder.InsertData(
                table: "Novosti",
                columns: new[] { "NovostiId", "DatumObjave", "KorisnikId", "Naslov", "Sadrzaj", "Slika" },
                values: new object[,]
                {
                    { 1, new DateTime(2024, 3, 29, 13, 55, 28, 192, DateTimeKind.Local).AddTicks(5760), 1, "Novi trendovi u frizurama", "Osvježite svoj izgled uz najnovije frizure koje su hit ove sezone! Naši stručnjaci su u toku sa najnovijim trendovima, stoga posjetite naš salon i otkrijte kako možete osvježiti svoj stil", null },
                    { 2, new DateTime(2024, 3, 29, 13, 55, 28, 192, DateTimeKind.Local).AddTicks(5764), 1, "Posebna ponuda za bojanje kose", "Vrijeme je za promjenu boje! U narednom mjesecu nudimo posebnu ponudu na usluge bojanja kose. Bez obzira želite li se osvježiti ili potpuno transformisati, naši stručnjaci će vam pomoći postići savršen izgled", null },
                    { 3, new DateTime(2024, 3, 29, 13, 55, 28, 192, DateTimeKind.Local).AddTicks(5766), 1, "Savjetovanje sa stilistom", "Želite li promjeniti frizuru, ali niste sigurni koji stil bi vam najbolje odgovarao? Zakažite savjetovanje sa našim stilistom koji će vam pomoći odabrati frizuru koja će najbolje istaći vaše karakteristike i stil", null }
                });

            migrationBuilder.InsertData(
                table: "Ocjene",
                columns: new[] { "Id", "Datum", "KorisnikId", "Ocjena", "Opis", "UposlenikId" },
                values: new object[,]
                {
                    { 1, new DateTime(2024, 3, 29, 13, 55, 28, 192, DateTimeKind.Local).AddTicks(5842), 1, 5.0, null, 1 },
                    { 2, new DateTime(2024, 3, 29, 13, 55, 28, 192, DateTimeKind.Local).AddTicks(5847), 2, 5.0, null, 2 },
                    { 3, new DateTime(2024, 3, 29, 13, 55, 28, 192, DateTimeKind.Local).AddTicks(5849), 3, 5.0, null, 3 },
                    { 4, new DateTime(2024, 3, 29, 13, 55, 28, 192, DateTimeKind.Local).AddTicks(5852), 4, 5.0, null, 4 }
                });

            migrationBuilder.InsertData(
                table: "Recenzije",
                columns: new[] { "RecenzijeId", "DatumObjave", "KorisnikId", "Ocjena", "Sadrzaj" },
                values: new object[,]
                {
                    { 1, new DateTime(2024, 3, 29, 13, 55, 28, 192, DateTimeKind.Local).AddTicks(5793), 3, 5.0, "Posjetio sam ovaj salon prvi put, i moram priznati da sam bio zadovoljan. Atmosfera je opuštajuća, a osoblje je bilo veoma prijateljsko. Frizerka je imala odlične sugestije i savjete za negu kose. Sve preporuke!" },
                    { 2, new DateTime(2024, 3, 29, 13, 55, 28, 192, DateTimeKind.Local).AddTicks(5797), 4, 4.0, "Odličan salon, vrlo moderno uređen. Osoblje je veoma ljubazno i usluga je bila vrhunska. Moj frizer je bio veoma stručan i posvetio se svakom detalju. Jedini razlog zašto ne dajem pet zvjezdica je cijena koja je bila malo viša nego što sam očekivao, ali kvalitet je definitivno bio tu." }
                });

            migrationBuilder.InsertData(
                table: "Rezervacija",
                columns: new[] { "RezervacijaId", "Datum", "KorisnikId", "Status", "UposlenikId", "UslugaId", "Vrijeme" },
                values: new object[,]
                {
                    { 1, new DateTime(2024, 1, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), 3, null, 1, 1, new DateTime(2024, 1, 5, 9, 30, 0, 0, DateTimeKind.Unspecified) },
                    { 2, new DateTime(2024, 1, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), 4, null, 1, 2, new DateTime(2024, 1, 5, 10, 15, 0, 0, DateTimeKind.Unspecified) },
                    { 3, new DateTime(2024, 1, 6, 0, 0, 0, 0, DateTimeKind.Unspecified), 3, null, 2, 1, new DateTime(2024, 1, 6, 9, 0, 0, 0, DateTimeKind.Unspecified) },
                    { 4, new DateTime(2024, 1, 6, 0, 0, 0, 0, DateTimeKind.Unspecified), 4, null, 2, 2, new DateTime(2024, 1, 6, 11, 30, 0, 0, DateTimeKind.Unspecified) }
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
                name: "IX_Ocjene_KorisnikId",
                table: "Ocjene",
                column: "KorisnikId");

            migrationBuilder.CreateIndex(
                name: "IX_Ocjene_UposlenikId",
                table: "Ocjene",
                column: "UposlenikId");

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
                name: "IX_Rezervacija_UslugaId",
                table: "Rezervacija",
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
                name: "NarudzbeDetalji");

            migrationBuilder.DropTable(
                name: "Novosti");

            migrationBuilder.DropTable(
                name: "Ocjene");

            migrationBuilder.DropTable(
                name: "Placanje");

            migrationBuilder.DropTable(
                name: "Recenzije");

            migrationBuilder.DropTable(
                name: "Rezervacija");

            migrationBuilder.DropTable(
                name: "SlikeUsluge");

            migrationBuilder.DropTable(
                name: "Uloge");

            migrationBuilder.DropTable(
                name: "Proizvodi");

            migrationBuilder.DropTable(
                name: "Narudzbe");

            migrationBuilder.DropTable(
                name: "Uposlenik");

            migrationBuilder.DropTable(
                name: "Slike");

            migrationBuilder.DropTable(
                name: "Usluga");

            migrationBuilder.DropTable(
                name: "VrsteProizvoda");

            migrationBuilder.DropTable(
                name: "Korisnici");

            migrationBuilder.DropTable(
                name: "Grad");

            migrationBuilder.DropTable(
                name: "Drzava");
        }
    }
}
