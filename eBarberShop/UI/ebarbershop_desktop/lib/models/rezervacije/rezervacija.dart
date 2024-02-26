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
  String? uposlenikIme;
  String? uposlenikPrezime;

  Rezervacija(this.rezervacijaId, this.datum, this.vrijeme, this.status,
      this.korisnikId, this.uposlenikId, this.uposlenikIme, this.uposlenikPrezime);

  factory Rezervacija.fromJson(Map<String, dynamic> json) => _$RezervacijaFromJson(json);

  Map<String, dynamic> toJson() => _$RezervacijaToJson(this);
}
