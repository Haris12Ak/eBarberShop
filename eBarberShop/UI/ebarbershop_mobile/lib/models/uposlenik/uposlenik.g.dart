// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'uposlenik.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Uposlenik _$UposlenikFromJson(Map<String, dynamic> json) => Uposlenik(
      json['uposlenikId'] as int,
      json['ime'] as String,
      json['prezime'] as String,
      json['kontaktTelefon'] as String,
      json['email'] as String?,
      json['adresa'] as String?,
      (json['prosjecnaOcjena'] as num).toDouble(),
    );

Map<String, dynamic> _$UposlenikToJson(Uposlenik instance) => <String, dynamic>{
      'uposlenikId': instance.uposlenikId,
      'ime': instance.ime,
      'prezime': instance.prezime,
      'kontaktTelefon': instance.kontaktTelefon,
      'email': instance.email,
      'adresa': instance.adresa,
      'prosjecnaOcjena': instance.prosjecnaOcjena,
    };
