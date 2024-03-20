import 'package:json_annotation/json_annotation.dart';

part 'rezervacija_usluge.g.dart';

@JsonSerializable()
class RezervacijaUsluge {
  int rezervacijaUslugeId;
  int rezervacijaId;
  int uslugaId;

  RezervacijaUsluge(this.rezervacijaUslugeId, this.rezervacijaId, this.uslugaId);

  factory RezervacijaUsluge.fromJson(Map<String, dynamic> json) =>
      _$RezervacijaUslugeFromJson(json);

  Map<String, dynamic> toJson() => _$RezervacijaUslugeToJson(this);
}