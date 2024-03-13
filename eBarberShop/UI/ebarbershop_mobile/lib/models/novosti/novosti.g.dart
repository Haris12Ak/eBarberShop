// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'novosti.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Novosti _$NovostiFromJson(Map<String, dynamic> json) => Novosti(
      json['novostiId'] as int,
      json['naslov'] as String,
      json['sadrzaj'] as String,
      DateTime.parse(json['datumObjave'] as String),
      json['slika'] as String?,
      json['korisnikId'] as int,
      json['korisnikImePrezime'] as String?,
    );

Map<String, dynamic> _$NovostiToJson(Novosti instance) => <String, dynamic>{
      'novostiId': instance.novostiId,
      'naslov': instance.naslov,
      'sadrzaj': instance.sadrzaj,
      'datumObjave': instance.datumObjave.toIso8601String(),
      'slika': instance.slika,
      'korisnikId': instance.korisnikId,
      'korisnikImePrezime': instance.korisnikImePrezime,
    };
