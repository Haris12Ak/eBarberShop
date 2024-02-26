import 'package:json_annotation/json_annotation.dart';

part 'termini.g.dart';

@JsonSerializable()
class Termini {
  DateTime datum;
  DateTime vrijeme;

  Termini(this.datum, this.vrijeme);

  factory Termini.fromJson(Map<String, dynamic> json) =>
      _$TerminiFromJson(json);

  Map<String, dynamic> toJson() => _$TerminiToJson(this);
}