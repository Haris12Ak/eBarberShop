// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'termini.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Termini _$TerminiFromJson(Map<String, dynamic> json) => Termini(
      DateTime.parse(json['datum'] as String),
      DateTime.parse(json['vrijeme'] as String),
    );

Map<String, dynamic> _$TerminiToJson(Termini instance) => <String, dynamic>{
      'datum': instance.datum.toIso8601String(),
      'vrijeme': instance.vrijeme.toIso8601String(),
    };
