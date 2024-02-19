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

  Uposlenik(this.uposlenikId, this.ime, this.prezime, this.kontaktTelefon, this.email, this.adresa);

  factory Uposlenik.fromJson(Map<String, dynamic> json) =>
      _$UposlenikFromJson(json);

  Map<String, dynamic> toJson() => _$UposlenikToJson(this);

}