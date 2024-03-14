using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eBarberShop.Services.Migrations
{
    /// <inheritdoc />
    public partial class promjenta_tipa_podatka_Ocjena_tabela_Recenzije : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<double>(
                name: "Ocjena",
                table: "Recenzije",
                type: "float",
                nullable: false,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "KorisniciId",
                keyValue: 1,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "ugYRpSCP8XZYOBzItpvGr8R9mBg=", "nTzA85SUSzR7XxZGZVfwKg==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "KorisniciId",
                keyValue: 2,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "8KlkZegsjG4dZr1limCsfJ7S1UI=", "2A8lbfScvlCaX4mRgeb0rg==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "KorisniciId",
                keyValue: 3,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "Yvs0mh/5ZD9SyHY2nSYmFqxZf78=", "EGY3u1vtdQKhRt9KM54CJA==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "KorisniciId",
                keyValue: 4,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "Jj4n4DxrmUeOc76oEvDYdJByoUw=", "CdJ4oY8jsogBmIFLTZ4kKA==" });

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisniciUlogeId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2024, 3, 14, 15, 27, 19, 589, DateTimeKind.Local).AddTicks(2120));

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisniciUlogeId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2024, 3, 14, 15, 27, 19, 589, DateTimeKind.Local).AddTicks(2222));

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisniciUlogeId",
                keyValue: 3,
                column: "DatumIzmjene",
                value: new DateTime(2024, 3, 14, 15, 27, 19, 589, DateTimeKind.Local).AddTicks(2225));

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisniciUlogeId",
                keyValue: 4,
                column: "DatumIzmjene",
                value: new DateTime(2024, 3, 14, 15, 27, 19, 589, DateTimeKind.Local).AddTicks(2228));

            migrationBuilder.UpdateData(
                table: "Narudzbe",
                keyColumn: "NarudzbeId",
                keyValue: 1,
                column: "DatumNarudzbe",
                value: new DateTime(2024, 3, 14, 15, 27, 19, 589, DateTimeKind.Local).AddTicks(2582));

            migrationBuilder.UpdateData(
                table: "Narudzbe",
                keyColumn: "NarudzbeId",
                keyValue: 2,
                column: "DatumNarudzbe",
                value: new DateTime(2024, 3, 14, 15, 27, 19, 589, DateTimeKind.Local).AddTicks(2588));

            migrationBuilder.UpdateData(
                table: "Narudzbe",
                keyColumn: "NarudzbeId",
                keyValue: 3,
                column: "DatumNarudzbe",
                value: new DateTime(2024, 3, 14, 15, 27, 19, 589, DateTimeKind.Local).AddTicks(2591));

            migrationBuilder.UpdateData(
                table: "Narudzbe",
                keyColumn: "NarudzbeId",
                keyValue: 4,
                column: "DatumNarudzbe",
                value: new DateTime(2024, 3, 14, 15, 27, 19, 589, DateTimeKind.Local).AddTicks(2595));

            migrationBuilder.UpdateData(
                table: "Novosti",
                keyColumn: "NovostiId",
                keyValue: 1,
                column: "DatumObjave",
                value: new DateTime(2024, 3, 14, 15, 27, 19, 589, DateTimeKind.Local).AddTicks(2252));

            migrationBuilder.UpdateData(
                table: "Novosti",
                keyColumn: "NovostiId",
                keyValue: 2,
                column: "DatumObjave",
                value: new DateTime(2024, 3, 14, 15, 27, 19, 589, DateTimeKind.Local).AddTicks(2256));

            migrationBuilder.UpdateData(
                table: "Novosti",
                keyColumn: "NovostiId",
                keyValue: 3,
                column: "DatumObjave",
                value: new DateTime(2024, 3, 14, 15, 27, 19, 589, DateTimeKind.Local).AddTicks(2259));

            migrationBuilder.UpdateData(
                table: "Recenzije",
                keyColumn: "RecenzijeId",
                keyValue: 1,
                columns: new[] { "DatumObjave", "Ocjena" },
                values: new object[] { new DateTime(2024, 3, 14, 15, 27, 19, 589, DateTimeKind.Local).AddTicks(2361), 5.0 });

            migrationBuilder.UpdateData(
                table: "Recenzije",
                keyColumn: "RecenzijeId",
                keyValue: 2,
                columns: new[] { "DatumObjave", "Ocjena" },
                values: new object[] { new DateTime(2024, 3, 14, 15, 27, 19, 589, DateTimeKind.Local).AddTicks(2366), 4.0 });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<int>(
                name: "Ocjena",
                table: "Recenzije",
                type: "int",
                nullable: false,
                oldClrType: typeof(double),
                oldType: "float");

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "KorisniciId",
                keyValue: 1,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "atJ9u3e7ql1Fupbm/Qiu9wOmsHA=", "EVgU2BPeThoDDheO3xwkxA==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "KorisniciId",
                keyValue: 2,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "UU4+tHWzQwSaatA/f23WznbyvX0=", "XXh7gVQ6JlhMruLRUCPscg==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "KorisniciId",
                keyValue: 3,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "SSCet0mbf5AKKV6gnqtUZacqQhU=", "hLljAq4KB58HLJ3pXgbt9Q==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "KorisniciId",
                keyValue: 4,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "C/4M8AXV2R6w3TQNz7DMXU4RaQo=", "FCvcNESfV3xCUA2pbIvodg==" });

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisniciUlogeId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2024, 2, 22, 21, 56, 55, 134, DateTimeKind.Local).AddTicks(3903));

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisniciUlogeId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2024, 2, 22, 21, 56, 55, 134, DateTimeKind.Local).AddTicks(3952));

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisniciUlogeId",
                keyValue: 3,
                column: "DatumIzmjene",
                value: new DateTime(2024, 2, 22, 21, 56, 55, 134, DateTimeKind.Local).AddTicks(3955));

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisniciUlogeId",
                keyValue: 4,
                column: "DatumIzmjene",
                value: new DateTime(2024, 2, 22, 21, 56, 55, 134, DateTimeKind.Local).AddTicks(3958));

            migrationBuilder.UpdateData(
                table: "Narudzbe",
                keyColumn: "NarudzbeId",
                keyValue: 1,
                column: "DatumNarudzbe",
                value: new DateTime(2024, 2, 22, 21, 56, 55, 134, DateTimeKind.Local).AddTicks(4266));

            migrationBuilder.UpdateData(
                table: "Narudzbe",
                keyColumn: "NarudzbeId",
                keyValue: 2,
                column: "DatumNarudzbe",
                value: new DateTime(2024, 2, 22, 21, 56, 55, 134, DateTimeKind.Local).AddTicks(4272));

            migrationBuilder.UpdateData(
                table: "Narudzbe",
                keyColumn: "NarudzbeId",
                keyValue: 3,
                column: "DatumNarudzbe",
                value: new DateTime(2024, 2, 22, 21, 56, 55, 134, DateTimeKind.Local).AddTicks(4275));

            migrationBuilder.UpdateData(
                table: "Narudzbe",
                keyColumn: "NarudzbeId",
                keyValue: 4,
                column: "DatumNarudzbe",
                value: new DateTime(2024, 2, 22, 21, 56, 55, 134, DateTimeKind.Local).AddTicks(4279));

            migrationBuilder.UpdateData(
                table: "Novosti",
                keyColumn: "NovostiId",
                keyValue: 1,
                column: "DatumObjave",
                value: new DateTime(2024, 2, 22, 21, 56, 55, 134, DateTimeKind.Local).AddTicks(3978));

            migrationBuilder.UpdateData(
                table: "Novosti",
                keyColumn: "NovostiId",
                keyValue: 2,
                column: "DatumObjave",
                value: new DateTime(2024, 2, 22, 21, 56, 55, 134, DateTimeKind.Local).AddTicks(3982));

            migrationBuilder.UpdateData(
                table: "Novosti",
                keyColumn: "NovostiId",
                keyValue: 3,
                column: "DatumObjave",
                value: new DateTime(2024, 2, 22, 21, 56, 55, 134, DateTimeKind.Local).AddTicks(3985));

            migrationBuilder.UpdateData(
                table: "Recenzije",
                keyColumn: "RecenzijeId",
                keyValue: 1,
                columns: new[] { "DatumObjave", "Ocjena" },
                values: new object[] { new DateTime(2024, 2, 22, 21, 56, 55, 134, DateTimeKind.Local).AddTicks(4005), 5 });

            migrationBuilder.UpdateData(
                table: "Recenzije",
                keyColumn: "RecenzijeId",
                keyValue: 2,
                columns: new[] { "DatumObjave", "Ocjena" },
                values: new object[] { new DateTime(2024, 2, 22, 21, 56, 55, 134, DateTimeKind.Local).AddTicks(4009), 4 });
        }
    }
}
