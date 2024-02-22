import 'package:json_annotation/json_annotation.dart';

part 'slike.g.dart';

@JsonSerializable()
class Slike {
  int slikeId;
  String? opis;
  String slika;
  DateTime datumPostavljanja;

  Slike(this.slikeId, this.opis, this.slika, this.datumPostavljanja);

  factory Slike.fromJson(Map<String, dynamic> json) =>
      _$SlikeFromJson(json);

  Map<String, dynamic> toJson() => _$SlikeToJson(this);
}
