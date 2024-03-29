import 'package:json_annotation/json_annotation.dart';

part 'rezervacija_insert_request.g.dart';

@JsonSerializable()
class RezervacijaInsertRequest{
  DateTime datum;
  DateTime vrijeme;
  bool? status;
  int korisnikId;
  int uposlenikId;
  int uslugaId;

  RezervacijaInsertRequest(this.datum, this.vrijeme, this.status, this.korisnikId, this.uposlenikId, this.uslugaId);

  factory RezervacijaInsertRequest.fromJson(Map<String, dynamic> json) => _$RezervacijaInsertRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RezervacijaInsertRequestToJson(this);
}