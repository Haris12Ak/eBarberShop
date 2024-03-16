import 'package:json_annotation/json_annotation.dart';

part 'korisnik.g.dart';

@JsonSerializable()
class Korisnik {
  int korisniciId;
  String ime;
  String prezime;
  String korisnickoIme;
  String? email;
  String? adresa;
  String? brojTelefona;
  bool? status;
  String? slika;
  int gradId;
  String? gradNaziv;

  Korisnik(
      this.korisniciId,
      this.ime,
      this.prezime,
      this.korisnickoIme,
      this.email,
      this.adresa,
      this.brojTelefona,
      this.status,
      this.slika,
      this.gradId,
      this.gradNaziv);

  factory Korisnik.fromJson(Map<String, dynamic> json) =>
      _$KorisnikFromJson(json);

  Map<String, dynamic> toJson() => _$KorisnikToJson(this);
}
