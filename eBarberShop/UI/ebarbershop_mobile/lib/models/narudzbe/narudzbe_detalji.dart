import 'package:json_annotation/json_annotation.dart';

part 'narudzbe_detalji.g.dart';

@JsonSerializable()
class NarudzbeDetalji {
  int narudzbeDetaljiId;
  int kolicina;
  int narudzbaId;
  int proizvodId;

  NarudzbeDetalji(
      this.narudzbeDetaljiId, this.kolicina, this.narudzbaId, this.proizvodId);

  factory NarudzbeDetalji.fromJson(Map<String, dynamic> json) =>
      _$NarudzbeDetaljiFromJson(json);

  Map<String, dynamic> toJson() => _$NarudzbeDetaljiToJson(this);
}
