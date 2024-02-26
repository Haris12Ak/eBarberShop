import 'package:json_annotation/json_annotation.dart';

part 'rezervacija_insert.g.dart';

@JsonSerializable()
class RezervacijaInsert {
  DateTime datum;
  DateTime vrijeme;
  bool? status;
  int korisnikId;
  int uposlenikId;

  RezervacijaInsert(this.datum, this.vrijeme, this.status, this.korisnikId, this.uposlenikId);

  factory RezervacijaInsert.fromJson(Map<String, dynamic> json) => _$RezervacijaInsertFromJson(json);

  Map<String, dynamic> toJson() => _$RezervacijaInsertToJson(this);
}