import 'package:json_annotation/json_annotation.dart';

part 'grad.g.dart';

@JsonSerializable()
class Grad {
  int gradId;
  String naziv;
  String? opis;
  int drzavaId;

  Grad(this.gradId, this.naziv, this.opis, this.drzavaId);

  factory Grad.fromJson(Map<String, dynamic> json) => _$GradFromJson(json);

  Map<String, dynamic> toJson() => _$GradToJson(this);
}