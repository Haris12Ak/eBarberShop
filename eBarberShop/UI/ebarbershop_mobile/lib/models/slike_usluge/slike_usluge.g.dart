// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slike_usluge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SlikeUsluge _$SlikeUslugeFromJson(Map<String, dynamic> json) => SlikeUsluge(
      json['slikeUslugeId'] as int,
      json['slikaId'] as int,
      json['slikaUsluga'] as String?,
      json['opisSlike'] as String?,
      json['datumObjave'] == null
          ? null
          : DateTime.parse(json['datumObjave'] as String),
    );

Map<String, dynamic> _$SlikeUslugeToJson(SlikeUsluge instance) =>
    <String, dynamic>{
      'slikeUslugeId': instance.slikeUslugeId,
      'slikaId': instance.slikaId,
      'slikaUsluga': instance.slikaUsluga,
      'opisSlike': instance.opisSlike,
      'datumObjave': instance.datumObjave?.toIso8601String(),
    };
