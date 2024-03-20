// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recenzije.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recenzije _$RecenzijeFromJson(Map<String, dynamic> json) => Recenzije(
      json['recenzijeId'] as int,
      json['sadrzaj'] as String,
      (json['ocjena'] as num).toDouble(),
      DateTime.parse(json['datumObjave'] as String),
      json['korisnikId'] as int,
      json['korisnik'] == null
          ? null
          : Korisnik.fromJson(json['korisnik'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RecenzijeToJson(Recenzije instance) => <String, dynamic>{
      'recenzijeId': instance.recenzijeId,
      'sadrzaj': instance.sadrzaj,
      'ocjena': instance.ocjena,
      'datumObjave': instance.datumObjave.toIso8601String(),
      'korisnikId': instance.korisnikId,
      'korisnik': instance.korisnik,
    };
