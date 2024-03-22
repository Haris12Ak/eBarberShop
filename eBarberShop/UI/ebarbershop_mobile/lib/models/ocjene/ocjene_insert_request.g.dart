// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ocjene_insert_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OcjeneInsertRequest _$OcjeneInsertRequestFromJson(Map<String, dynamic> json) =>
    OcjeneInsertRequest(
      DateTime.parse(json['datum'] as String),
      (json['ocjena'] as num).toDouble(),
      json['opis'] as String?,
      json['uposlenikId'] as int,
      json['korisnikId'] as int,
    );

Map<String, dynamic> _$OcjeneInsertRequestToJson(
        OcjeneInsertRequest instance) =>
    <String, dynamic>{
      'datum': instance.datum.toIso8601String(),
      'ocjena': instance.ocjena,
      'opis': instance.opis,
      'uposlenikId': instance.uposlenikId,
      'korisnikId': instance.korisnikId,
    };
