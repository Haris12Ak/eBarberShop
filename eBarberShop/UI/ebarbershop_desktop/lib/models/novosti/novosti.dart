import 'package:json_annotation/json_annotation.dart';

part 'novosti.g.dart';

@JsonSerializable()
class Novosti {
  int novostiId;
  String naslov;
  String sadrzaj;
  DateTime datumObjave;
  String? slika;
  int korisnikId;
  String? korisnikImePrezime;

  Novosti(this.novostiId, this.naslov, this.sadrzaj, this.datumObjave, this.slika, this.korisnikId, this.korisnikImePrezime);

  factory Novosti.fromJson(Map<String, dynamic> json) =>
      _$NovostiFromJson(json);

  Map<String, dynamic> toJson() => _$NovostiToJson(this);
}
