import 'package:json_annotation/json_annotation.dart';

part 'uposlenik.g.dart';

@JsonSerializable()
class Uposlenik {
  int uposlenikId;
  String ime;
  String prezime;
  String kontaktTelefon;
  String? email;
  String? adresa;
  double prosjecnaOcjena;

  Uposlenik(this.uposlenikId, this.ime, this.prezime, this.kontaktTelefon, this.email, this.adresa, this.prosjecnaOcjena);

  factory Uposlenik.fromJson(Map<String, dynamic> json) =>
      _$UposlenikFromJson(json);

  Map<String, dynamic> toJson() => _$UposlenikToJson(this);

}