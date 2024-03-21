import 'package:json_annotation/json_annotation.dart';

part 'slike_usluge.g.dart';

@JsonSerializable()
class SlikeUsluge {
  int slikeUslugeId;
  int slikaId;
  String? slikaUsluga;
  String? opisSlike;
  DateTime? datumObjave;

  SlikeUsluge(this.slikeUslugeId, this.slikaId, this.slikaUsluga, this.opisSlike, this.datumObjave);

  factory SlikeUsluge.fromJson(Map<String, dynamic> json) =>
      _$SlikeUslugeFromJson(json);

  Map<String, dynamic> toJson() => _$SlikeUslugeToJson(this);
}