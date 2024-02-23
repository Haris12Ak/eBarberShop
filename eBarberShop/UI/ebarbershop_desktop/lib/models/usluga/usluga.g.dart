// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usluga.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Usluga _$UslugaFromJson(Map<String, dynamic> json) => Usluga(
      json['uslugaId'] as int,
      json['naziv'] as String,
      json['opis'] as String?,
      (json['cijena'] as num).toDouble(),
      json['trajanje'] as int,
    );

Map<String, dynamic> _$UslugaToJson(Usluga instance) => <String, dynamic>{
      'uslugaId': instance.uslugaId,
      'naziv': instance.naziv,
      'opis': instance.opis,
      'cijena': instance.cijena,
      'trajanje': instance.trajanje,
    };
