import 'package:json_annotation/json_annotation.dart';

part 'recenzije.g.dart';

@JsonSerializable()
class Recenzije {
  int recenzijeId;
  String sadrzaj;
  double ocjena;
  DateTime datumObjave;
  int korisnikId;
  String? imeKorisnika;
  String? prezimeKorisnika;

  Recenzije(this.recenzijeId, this.sadrzaj, this.ocjena, this.datumObjave,
      this.korisnikId, this.imeKorisnika, this.prezimeKorisnika);

      factory Recenzije.fromJson(Map<String, dynamic> json) =>
      _$RecenzijeFromJson(json);

  Map<String, dynamic> toJson() => _$RecenzijeToJson(this);
}