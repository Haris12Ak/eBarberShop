// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slike.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Slike _$SlikeFromJson(Map<String, dynamic> json) => Slike(
      json['slikeId'] as int,
      json['opis'] as String?,
      json['slika'] as String,
      DateTime.parse(json['datumPostavljanja'] as String),
    );

Map<String, dynamic> _$SlikeToJson(Slike instance) => <String, dynamic>{
      'slikeId': instance.slikeId,
      'opis': instance.opis,
      'slika': instance.slika,
      'datumPostavljanja': instance.datumPostavljanja.toIso8601String(),
    };
