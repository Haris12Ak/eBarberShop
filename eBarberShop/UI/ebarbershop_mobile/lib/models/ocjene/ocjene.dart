import 'package:json_annotation/json_annotation.dart';

part 'ocjene.g.dart';

@JsonSerializable()
class Ocjene {
  int id;
  DateTime datum;
  double ocjena;
  String? opis;
  int uposlenikId;
  int korisnikId;
  String? korisnickoIme;

  Ocjene(this.id, this.datum, this.ocjena, this.opis, this.uposlenikId, this.korisnikId, this.korisnickoIme);

  factory Ocjene.fromJson(Map<String, dynamic> json) =>
      _$OcjeneFromJson(json);

  Map<String, dynamic> toJson() => _$OcjeneToJson(this);
}