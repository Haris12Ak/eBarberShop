// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grad.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Grad _$GradFromJson(Map<String, dynamic> json) => Grad(
      json['gradId'] as int,
      json['naziv'] as String,
      json['opis'] as String?,
      json['drzavaId'] as int,
    );

Map<String, dynamic> _$GradToJson(Grad instance) => <String, dynamic>{
      'gradId': instance.gradId,
      'naziv': instance.naziv,
      'opis': instance.opis,
      'drzavaId': instance.drzavaId,
    };
