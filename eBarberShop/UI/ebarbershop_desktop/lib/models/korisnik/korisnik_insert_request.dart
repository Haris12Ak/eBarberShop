import 'package:json_annotation/json_annotation.dart';

part 'korisnik_insert_request.g.dart';

@JsonSerializable()
class KorisnikInsertRequest {
  String ime;
  String prezime;
  String email;
  String? adresa;
  String? brojTelefona;
  String korisnickoIme;
  String lozinka;
  String lozinkaPotvrda;
  bool? status;
  String? slika;
  int gradId;

  KorisnikInsertRequest(this.ime, this.prezime, this.email, this.adresa,
      this.brojTelefona, this.korisnickoIme, this.lozinka, this.lozinkaPotvrda, this.status, this.slika, this.gradId);

  factory KorisnikInsertRequest.fromJson(Map<String, dynamic> json) =>
      _$KorisnikInsertRequestFromJson(json);

  Map<String, dynamic> toJson() => _$KorisnikInsertRequestToJson(this);
}