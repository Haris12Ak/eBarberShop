using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eBarberShop.Services.Migrations
{
    /// <inheritdoc />
    public partial class added_new_table_Ocjene : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "KorisnikId",
                table: "Ocjene",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "KorisniciId",
                keyValue: 1,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "Lznyl0CVJFRyvZ+Yqegg0TKUJQM=", "6F7c7fMhQm/j1t1PcG+Axw==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "KorisniciId",
                keyValue: 2,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "k8GrF4QUtgWGr1kKIfdn2heKhVM=", "wRo33cB8n9eN62XUtR6UbA==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "KorisniciId",
                keyValue: 3,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "I+yx/EEZwXqB2J+23XLgizYtriU=", "Z2NNoPcthFUFCdaicsbBiQ==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "KorisniciId",
                keyValue: 4,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "JOAKNgs3t+vTqch/a4CxOTRJ1L0=", "0I+/dN48sRTSZGYhwa6qbg==" });

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisniciUlogeId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2024, 3, 22, 13, 38, 9, 775, DateTimeKind.Local).AddTicks(2139));

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisniciUlogeId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2024, 3, 22, 13, 38, 9, 775, DateTimeKind.Local).AddTicks(2183));

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisniciUlogeId",
                keyValue: 3,
                column: "DatumIzmjene",
                value: new DateTime(2024, 3, 22, 13, 38, 9, 775, DateTimeKind.Local).AddTicks(2186));

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisniciUlogeId",
                keyValue: 4,
                column: "DatumIzmjene",
                value: new DateTime(2024, 3, 22, 13, 38, 9, 775, DateTimeKind.Local).AddTicks(2189));

            migrationBuilder.UpdateData(
                table: "Narudzbe",
                keyColumn: "NarudzbeId",
                keyValue: 1,
                column: "DatumNarudzbe",
                value: new DateTime(2024, 3, 22, 13, 38, 9, 775, DateTimeKind.Local).AddTicks(2551));

            migrationBuilder.UpdateData(
                table: "Narudzbe",
                keyColumn: "NarudzbeId",
                keyValue: 2,
                column: "DatumNarudzbe",
                value: new DateTime(2024, 3, 22, 13, 38, 9, 775, DateTimeKind.Local).AddTicks(2557));

            migrationBuilder.UpdateData(
                table: "Narudzbe",
                keyColumn: "NarudzbeId",
                keyValue: 3,
                column: "DatumNarudzbe",
                value: new DateTime(2024, 3, 22, 13, 38, 9, 775, DateTimeKind.Local).AddTicks(2561));

            migrationBuilder.UpdateData(
                table: "Narudzbe",
                keyColumn: "NarudzbeId",
                keyValue: 4,
                column: "DatumNarudzbe",
                value: new DateTime(2024, 3, 22, 13, 38, 9, 775, DateTimeKind.Local).AddTicks(2565));

            migrationBuilder.UpdateData(
                table: "Novosti",
                keyColumn: "NovostiId",
                keyValue: 1,
                column: "DatumObjave",
                value: new DateTime(2024, 3, 22, 13, 38, 9, 775, DateTimeKind.Local).AddTicks(2213));

            migrationBuilder.UpdateData(
                table: "Novosti",
                keyColumn: "NovostiId",
                keyValue: 2,
                column: "DatumObjave",
                value: new DateTime(2024, 3, 22, 13, 38, 9, 775, DateTimeKind.Local).AddTicks(2217));

            migrationBuilder.UpdateData(
                table: "Novosti",
                keyColumn: "NovostiId",
                keyValue: 3,
                column: "DatumObjave",
                value: new DateTime(2024, 3, 22, 13, 38, 9, 775, DateTimeKind.Local).AddTicks(2219));

            migrationBuilder.UpdateData(
                table: "Recenzije",
                keyColumn: "RecenzijeId",
                keyValue: 1,
                column: "DatumObjave",
                value: new DateTime(2024, 3, 22, 13, 38, 9, 775, DateTimeKind.Local).AddTicks(2244));

            migrationBuilder.UpdateData(
                table: "Recenzije",
                keyColumn: "RecenzijeId",
                keyValue: 2,
                column: "DatumObjave",
                value: new DateTime(2024, 3, 22, 13, 38, 9, 775, DateTimeKind.Local).AddTicks(2247));

            migrationBuilder.CreateIndex(
                name: "IX_Ocjene_KorisnikId",
                table: "Ocjene",
                column: "KorisnikId");

            migrationBuilder.AddForeignKey(
                name: "FK_Ocjene_Korisnici_KorisnikId",
                table: "Ocjene",
                column: "KorisnikId",
                principalTable: "Korisnici",
                principalColumn: "KorisniciId",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Ocjene_Korisnici_KorisnikId",
                table: "Ocjene");

            migrationBuilder.DropIndex(
                name: "IX_Ocjene_KorisnikId",
                table: "Ocjene");

            migrationBuilder.DropColumn(
                name: "KorisnikId",
                table: "Ocjene");

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "KorisniciId",
                keyValue: 1,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "+/n/S+L35Ld8ArR1otmsTKjByaE=", "zPfOlKsd8J30u39nb76zFA==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "KorisniciId",
                keyValue: 2,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "kzSzKIZUj7INA7IzcW0GPEtyCgA=", "oyjx2AtlmEZlD5uqV0bW5A==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "KorisniciId",
                keyValue: 3,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "vbWywW27Giw7PKF/YaZenMjrZU0=", "0qcQI7z4chJPwff5bacQEg==" });

            migrationBuilder.UpdateData(
                table: "Korisnici",
                keyColumn: "KorisniciId",
                keyValue: 4,
                columns: new[] { "LozinkaHash", "LozinkaSalt" },
                values: new object[] { "4mNpbXeK/OHC0iJnJcvhADyyQyE=", "zYEpxHA8D3S2FZmKRP0O9g==" });

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisniciUlogeId",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2024, 3, 22, 2, 13, 50, 855, DateTimeKind.Local).AddTicks(4660));

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisniciUlogeId",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2024, 3, 22, 2, 13, 50, 855, DateTimeKind.Local).AddTicks(4715));

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisniciUlogeId",
                keyValue: 3,
                column: "DatumIzmjene",
                value: new DateTime(2024, 3, 22, 2, 13, 50, 855, DateTimeKind.Local).AddTicks(4720));

            migrationBuilder.UpdateData(
                table: "KorisniciUloge",
                keyColumn: "KorisniciUlogeId",
                keyValue: 4,
                column: "DatumIzmjene",
                value: new DateTime(2024, 3, 22, 2, 13, 50, 855, DateTimeKind.Local).AddTicks(4724));

            migrationBuilder.UpdateData(
                table: "Narudzbe",
                keyColumn: "NarudzbeId",
                keyValue: 1,
                column: "DatumNarudzbe",
                value: new DateTime(2024, 3, 22, 2, 13, 50, 855, DateTimeKind.Local).AddTicks(5145));

            migrationBuilder.UpdateData(
                table: "Narudzbe",
                keyColumn: "NarudzbeId",
                keyValue: 2,
                column: "DatumNarudzbe",
                value: new DateTime(2024, 3, 22, 2, 13, 50, 855, DateTimeKind.Local).AddTicks(5153));

            migrationBuilder.UpdateData(
                table: "Narudzbe",
                keyColumn: "NarudzbeId",
                keyValue: 3,
                column: "DatumNarudzbe",
                value: new DateTime(2024, 3, 22, 2, 13, 50, 855, DateTimeKind.Local).AddTicks(5158));

            migrationBuilder.UpdateData(
                table: "Narudzbe",
                keyColumn: "NarudzbeId",
                keyValue: 4,
                column: "DatumNarudzbe",
                value: new DateTime(2024, 3, 22, 2, 13, 50, 855, DateTimeKind.Local).AddTicks(5162));

            migrationBuilder.UpdateData(
                table: "Novosti",
                keyColumn: "NovostiId",
                keyValue: 1,
                column: "DatumObjave",
                value: new DateTime(2024, 3, 22, 2, 13, 50, 855, DateTimeKind.Local).AddTicks(4754));

            migrationBuilder.UpdateData(
                table: "Novosti",
                keyColumn: "NovostiId",
                keyValue: 2,
                column: "DatumObjave",
                value: new DateTime(2024, 3, 22, 2, 13, 50, 855, DateTimeKind.Local).AddTicks(4759));

            migrationBuilder.UpdateData(
                table: "Novosti",
                keyColumn: "NovostiId",
                keyValue: 3,
                column: "DatumObjave",
                value: new DateTime(2024, 3, 22, 2, 13, 50, 855, DateTimeKind.Local).AddTicks(4763));

            migrationBuilder.UpdateData(
                table: "Recenzije",
                keyColumn: "RecenzijeId",
                keyValue: 1,
                column: "DatumObjave",
                value: new DateTime(2024, 3, 22, 2, 13, 50, 855, DateTimeKind.Local).AddTicks(4794));

            migrationBuilder.UpdateData(
                table: "Recenzije",
                keyColumn: "RecenzijeId",
                keyValue: 2,
                column: "DatumObjave",
                value: new DateTime(2024, 3, 22, 2, 13, 50, 855, DateTimeKind.Local).AddTicks(4799));
        }
    }
}
