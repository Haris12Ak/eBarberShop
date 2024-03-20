// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rezervacija_insert_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RezervacijaInsertRequest _$RezervacijaInsertRequestFromJson(
        Map<String, dynamic> json) =>
    RezervacijaInsertRequest(
      DateTime.parse(json['datum'] as String),
      DateTime.parse(json['vrijeme'] as String),
      json['status'] as bool?,
      json['korisnikId'] as int,
      json['uposlenikId'] as int,
    );

Map<String, dynamic> _$RezervacijaInsertRequestToJson(
        RezervacijaInsertRequest instance) =>
    <String, dynamic>{
      'datum': instance.datum.toIso8601String(),
      'vrijeme': instance.vrijeme.toIso8601String(),
      'status': instance.status,
      'korisnikId': instance.korisnikId,
      'uposlenikId': instance.uposlenikId,
    };
