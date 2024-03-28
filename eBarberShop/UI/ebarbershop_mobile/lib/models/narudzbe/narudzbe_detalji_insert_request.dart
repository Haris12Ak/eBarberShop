import 'package:json_annotation/json_annotation.dart';

part 'narudzbe_detalji_insert_request.g.dart';

@JsonSerializable()
class NarudzbeDetaljiInsertRequest {
  int kolicina;
  int narudzbaId;
  int proizvodId;

  NarudzbeDetaljiInsertRequest(this.kolicina, this.narudzbaId, this.proizvodId);

  factory NarudzbeDetaljiInsertRequest.fromJson(Map<String, dynamic> json) =>
      _$NarudzbeDetaljiInsertRequestFromJson(json);

  Map<String, dynamic> toJson() => _$NarudzbeDetaljiInsertRequestToJson(this);
}
