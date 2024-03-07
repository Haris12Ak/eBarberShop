import 'package:json_annotation/json_annotation.dart';

part 'narudzbe.g.dart';

@JsonSerializable()
class Narudzbe {
  int narudzbeId;
  String brojNarudzbe;
  DateTime datumNarudzbe;
  double ukupanIznos;
  bool status;
  bool? otkazano;
  int korisnikId;
  String? imeKorisnika;
  String? prezimeKorisnika;

  Narudzbe(this.narudzbeId, this.brojNarudzbe, this.datumNarudzbe, this.ukupanIznos, this.status, this.otkazano, this.korisnikId, this.imeKorisnika, this.prezimeKorisnika);

  factory Narudzbe.fromJson(Map<String, dynamic> json) =>
      _$NarudzbeFromJson(json);

  Map<String, dynamic> toJson() => _$NarudzbeToJson(this);
}
