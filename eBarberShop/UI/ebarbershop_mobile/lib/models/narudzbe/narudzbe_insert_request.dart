import 'package:json_annotation/json_annotation.dart';

part 'narudzbe_insert_request.g.dart';

@JsonSerializable()
class NarudzbeInsertRequest {
  DateTime datumNarudzbe;
  double ukupanIznos;
  bool status;
  bool? otkazano;
  int korisnikId;

  NarudzbeInsertRequest(this.datumNarudzbe, this.ukupanIznos, this.status, this.otkazano, this.korisnikId);

factory NarudzbeInsertRequest.fromJson(Map<String, dynamic> json) =>
      _$NarudzbeInsertRequestFromJson(json);

  Map<String, dynamic> toJson() => _$NarudzbeInsertRequestToJson(this);
}
