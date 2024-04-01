// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'narudzbe_update_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NarudzbeUpdateRequest _$NarudzbeUpdateRequestFromJson(
        Map<String, dynamic> json) =>
    NarudzbeUpdateRequest(
      DateTime.parse(json['datumNarudzbe'] as String),
      (json['ukupanIznos'] as num).toDouble(),
      json['status'] as bool,
      json['otkazano'] as bool?,
      json['korisnikId'] as int,
    );

Map<String, dynamic> _$NarudzbeUpdateRequestToJson(
        NarudzbeUpdateRequest instance) =>
    <String, dynamic>{
      'datumNarudzbe': instance.datumNarudzbe.toIso8601String(),
      'ukupanIznos': instance.ukupanIznos,
      'status': instance.status,
      'otkazano': instance.otkazano,
      'korisnikId': instance.korisnikId,
    };
