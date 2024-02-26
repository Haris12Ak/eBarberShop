// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rezervacija_insert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RezervacijaInsert _$RezervacijaInsertFromJson(Map<String, dynamic> json) =>
    RezervacijaInsert(
      DateTime.parse(json['datum'] as String),
      DateTime.parse(json['vrijeme'] as String),
      json['status'] as bool?,
      json['korisnikId'] as int,
      json['uposlenikId'] as int,
    );

Map<String, dynamic> _$RezervacijaInsertToJson(RezervacijaInsert instance) =>
    <String, dynamic>{
      'datum': instance.datum.toIso8601String(),
      'vrijeme': instance.vrijeme.toIso8601String(),
      'status': instance.status,
      'korisnikId': instance.korisnikId,
      'uposlenikId': instance.uposlenikId,
    };
