import 'package:json_annotation/json_annotation.dart';

part 'rezervacija.g.dart';

@JsonSerializable()
class Rezervacija {
  int rezervacijaId;
  DateTime datum;
  DateTime vrijeme;
  bool? status;
  int korisnikId;
  int uposlenikId;
  int uslugaId;

  Rezervacija(this.rezervacijaId, this.datum, this.vrijeme, this.status,
      this.korisnikId, this.uposlenikId, this.uslugaId);

  factory Rezervacija.fromJson(Map<String, dynamic> json) => _$RezervacijaFromJson(json);

  Map<String, dynamic> toJson() => _$RezervacijaToJson(this);
}