// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ocjene.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ocjene _$OcjeneFromJson(Map<String, dynamic> json) => Ocjene(
      json['id'] as int,
      DateTime.parse(json['datum'] as String),
      (json['ocjena'] as num).toDouble(),
      json['opis'] as String?,
      json['uposlenikId'] as int,
      json['korisnikId'] as int,
      json['korisnickoIme'] as String?,
    );

Map<String, dynamic> _$OcjeneToJson(Ocjene instance) => <String, dynamic>{
      'id': instance.id,
      'datum': instance.datum.toIso8601String(),
      'ocjena': instance.ocjena,
      'opis': instance.opis,
      'uposlenikId': instance.uposlenikId,
      'korisnikId': instance.korisnikId,
      'korisnickoIme': instance.korisnickoIme,
    };
