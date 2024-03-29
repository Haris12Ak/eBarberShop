import 'package:json_annotation/json_annotation.dart';

part 'termini_korisnika_info.g.dart';

@JsonSerializable()
class TerminiKorisnikaInfo {
  int rezervacijaId;
  DateTime datum;
  DateTime vrijeme;
  String nazivUsluge;
  bool isAktivna;

  TerminiKorisnikaInfo(this.rezervacijaId, this.datum, this.vrijeme,this.nazivUsluge, this.isAktivna);

  factory TerminiKorisnikaInfo.fromJson(Map<String, dynamic> json) => _$TerminiKorisnikaInfoFromJson(json);

  Map<String, dynamic> toJson() => _$TerminiKorisnikaInfoToJson(this);
}