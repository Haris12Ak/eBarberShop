// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usluge_rezervacije_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UslugeRezervacijeInfo _$UslugeRezervacijeInfoFromJson(
        Map<String, dynamic> json) =>
    UslugeRezervacijeInfo(
      json['rezervacijaUslugeId'] as int,
      json['rezervacijaId'] as int,
      json['datumRezervacije'] == null
          ? null
          : DateTime.parse(json['datumRezervacije'] as String),
      json['vrijemeRezervacije'] == null
          ? null
          : DateTime.parse(json['vrijemeRezervacije'] as String),
      json['imeKlijenta'] as String?,
      json['prezimeKlijenta'] as String?,
    );

Map<String, dynamic> _$UslugeRezervacijeInfoToJson(
        UslugeRezervacijeInfo instance) =>
    <String, dynamic>{
      'rezervacijaUslugeId': instance.rezervacijaUslugeId,
      'rezervacijaId': instance.rezervacijaId,
      'datumRezervacije': instance.datumRezervacije?.toIso8601String(),
      'vrijemeRezervacije': instance.vrijemeRezervacije?.toIso8601String(),
      'imeKlijenta': instance.imeKlijenta,
      'prezimeKlijenta': instance.prezimeKlijenta,
    };
