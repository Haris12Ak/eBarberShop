import 'package:json_annotation/json_annotation.dart';

part 'usluge_rezervacije_info.g.dart';

@JsonSerializable()
class UslugeRezervacijeInfo{
  int rezervacijaUslugeId;
  int rezervacijaId;
  DateTime? datumRezervacije;
  DateTime? vrijemeRezervacije;
  String? imeKlijenta;
  String? prezimeKlijenta;

  UslugeRezervacijeInfo(this.rezervacijaUslugeId, this.rezervacijaId, this.datumRezervacije, this.vrijemeRezervacije, this.imeKlijenta, this.prezimeKlijenta);

  factory UslugeRezervacijeInfo.fromJson(Map<String, dynamic> json) =>
      _$UslugeRezervacijeInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UslugeRezervacijeInfoToJson(this);
}