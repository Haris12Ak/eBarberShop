// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rezervacija_usluge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RezervacijaUsluge _$RezervacijaUslugeFromJson(Map<String, dynamic> json) =>
    RezervacijaUsluge(
      json['rezervacijaUslugeId'] as int,
      json['rezervacijaId'] as int,
      json['uslugaId'] as int,
    );

Map<String, dynamic> _$RezervacijaUslugeToJson(RezervacijaUsluge instance) =>
    <String, dynamic>{
      'rezervacijaUslugeId': instance.rezervacijaUslugeId,
      'rezervacijaId': instance.rezervacijaId,
      'uslugaId': instance.uslugaId,
    };
