import 'package:json_annotation/json_annotation.dart';

part 'ocjene_insert_request.g.dart';

@JsonSerializable()
class OcjeneInsertRequest {
  DateTime datum;
  double ocjena;
  String? opis;
  int uposlenikId;
  int korisnikId;

  OcjeneInsertRequest(
      this.datum, this.ocjena, this.opis, this.uposlenikId, this.korisnikId);

  factory OcjeneInsertRequest.fromJson(Map<String, dynamic> json) =>
      _$OcjeneInsertRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OcjeneInsertRequestToJson(this);
}
