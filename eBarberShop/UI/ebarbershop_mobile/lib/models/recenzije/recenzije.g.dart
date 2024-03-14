// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recenzije.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recenzije _$RecenzijeFromJson(Map<String, dynamic> json) => Recenzije(
      json['recenzijeId'] as int,
      json['sadrzaj'] as String,
      json['ocjena'] as int,
      DateTime.parse(json['datumObjave'] as String),
      json['korisnikId'] as int,
      json['imeKorisnika'] as String?,
      json['prezimeKorisnika'] as String?,
    );

Map<String, dynamic> _$RecenzijeToJson(Recenzije instance) => <String, dynamic>{
      'recenzijeId': instance.recenzijeId,
      'sadrzaj': instance.sadrzaj,
      'ocjena': instance.ocjena,
      'datumObjave': instance.datumObjave.toIso8601String(),
      'korisnikId': instance.korisnikId,
      'imeKorisnika': instance.imeKorisnika,
      'prezimeKorisnika': instance.prezimeKorisnika,
    };
