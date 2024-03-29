import 'package:json_annotation/json_annotation.dart';

part 'vrste_proizvoda.g.dart';

@JsonSerializable()
class VrsteProizvoda {
  int vrsteProizvodaId;
  String naziv;
  String? opis;

  VrsteProizvoda(this.vrsteProizvodaId, this.naziv, this.opis);

  factory VrsteProizvoda.fromJson(Map<String, dynamic> json) =>
      _$VrsteProizvodaFromJson(json);

  Map<String, dynamic> toJson() => _$VrsteProizvodaToJson(this);
}