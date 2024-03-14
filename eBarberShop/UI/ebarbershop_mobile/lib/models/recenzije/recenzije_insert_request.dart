import 'package:json_annotation/json_annotation.dart';

part 'recenzije_insert_request.g.dart';

@JsonSerializable()
class RecenzijeInsertRequest {
  String sadrzaj;
  double ocjena;
  DateTime datumObjave;
  int korisnikId;

  RecenzijeInsertRequest(
      this.sadrzaj, this.ocjena, this.datumObjave, this.korisnikId);

  factory RecenzijeInsertRequest.fromJson(Map<String, dynamic> json) =>
      _$RecenzijeInsertRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RecenzijeInsertRequestToJson(this);
}