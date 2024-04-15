import 'package:json_annotation/json_annotation.dart';

part 'termini_uposlenika.g.dart';

@JsonSerializable()
class TerminiUposlenika{
  int uposlenikId;
  String imeUposlenika;
  String prezimeUposlenika;
  DateTime datum;
  int brojTermina;

  TerminiUposlenika(this.uposlenikId, this.imeUposlenika, this.prezimeUposlenika,this.datum, this.brojTermina);

 factory TerminiUposlenika.fromJson(Map<String, dynamic> json) =>
      _$TerminiUposlenikaFromJson(json);

  Map<String, dynamic> toJson() => _$TerminiUposlenikaToJson(this);
}