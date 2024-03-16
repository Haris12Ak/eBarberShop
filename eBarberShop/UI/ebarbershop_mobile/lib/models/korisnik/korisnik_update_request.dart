import 'package:json_annotation/json_annotation.dart';

part 'korisnik_update_request.g.dart';

@JsonSerializable()
class KorisnikUpdateRequest {
  String ime;
  String prezime;
  String korisnickoIme;
  String email;
  String? adresa;
  String? brojTelefona;
  bool? status;
  String? slika;
  int gradId;
  String? lozinka;
  String? lozinkaPotvrda;

  KorisnikUpdateRequest(this.ime, this.prezime, this.korisnickoIme, this.email,
      this.adresa, this.brojTelefona, this.status, this.slika, this.gradId, this.lozinka, this.lozinkaPotvrda);

  factory KorisnikUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$KorisnikUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$KorisnikUpdateRequestToJson(this);
}
