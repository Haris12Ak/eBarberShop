import 'package:json_annotation/json_annotation.dart';

part 'narudzbe_update_request.g.dart';

@JsonSerializable()
class NarudzbeUpdateRequest {
  DateTime datumNarudzbe;
  double ukupanIznos;
  bool status;
  bool? otkazano;
  int korisnikId;

  NarudzbeUpdateRequest(this.datumNarudzbe, this.ukupanIznos, this.status,
      this.otkazano, this.korisnikId);

  factory NarudzbeUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$NarudzbeUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$NarudzbeUpdateRequestToJson(this);
}
