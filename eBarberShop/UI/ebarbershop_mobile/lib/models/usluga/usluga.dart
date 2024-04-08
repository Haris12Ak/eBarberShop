import 'package:json_annotation/json_annotation.dart';

part 'usluga.g.dart';

@JsonSerializable()
class Usluga {
  int uslugaId;
  String naziv;
  String? opis;
  double cijena;
  int trajanje;
  String? slika;

  Usluga(this.uslugaId, this.naziv, this.opis, this.cijena, this.trajanje, this.slika);

  factory Usluga.fromJson(Map<String, dynamic> json) =>
      _$UslugaFromJson(json);

  Map<String, dynamic> toJson() => _$UslugaToJson(this);
}