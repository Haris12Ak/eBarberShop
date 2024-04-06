import 'package:json_annotation/json_annotation.dart';

part 'izvjestaj_rezervacije.g.dart';

@JsonSerializable()
class IzvjestajRezervacije {
  int ukupnoRezervacija;
  int ukupnoAktivnihRezervacija;
  int ukupnoNeaktivnihRezervacija;
  double zaradaPrethodnogDana;
  double zaradaPrethodneSemice;
  double zaradaPrethodnogMjeseca;
  int brojRezervacijaPrethodnogDana;
  int brojRezervacijaPrethodneSedmice;
  int brojRezervacijaPrethodnogMjeseca;
  int brojUsluga;
  String uposlenikSaNajviseRezervacija;
  String uslugaSaNajviseRezervacija;
  double ukupnaZarada;

  IzvjestajRezervacije(
      this.ukupnoRezervacija,
      this.ukupnoAktivnihRezervacija,
      this.ukupnoNeaktivnihRezervacija,
      this.zaradaPrethodnogDana,
      this.zaradaPrethodneSemice,
      this.zaradaPrethodnogMjeseca,
      this.brojRezervacijaPrethodnogDana,
      this.brojRezervacijaPrethodneSedmice,
      this.brojRezervacijaPrethodnogMjeseca,
      this.brojUsluga,
      this.uposlenikSaNajviseRezervacija,
      this.uslugaSaNajviseRezervacija,
      this.ukupnaZarada);

  factory IzvjestajRezervacije.fromJson(Map<String, dynamic> json) =>
      _$IzvjestajRezervacijeFromJson(json);

  Map<String, dynamic> toJson() => _$IzvjestajRezervacijeToJson(this);
}
