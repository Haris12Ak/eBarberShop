// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'termini_uposlenika.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TerminiUposlenika _$TerminiUposlenikaFromJson(Map<String, dynamic> json) =>
    TerminiUposlenika(
      json['uposlenikId'] as int,
      json['imeUposlenika'] as String,
      json['prezimeUposlenika'] as String,
      DateTime.parse(json['datum'] as String),
      json['brojTermina'] as int,
    );

Map<String, dynamic> _$TerminiUposlenikaToJson(TerminiUposlenika instance) =>
    <String, dynamic>{
      'uposlenikId': instance.uposlenikId,
      'imeUposlenika': instance.imeUposlenika,
      'prezimeUposlenika': instance.prezimeUposlenika,
      'datum': instance.datum.toIso8601String(),
      'brojTermina': instance.brojTermina,
    };
