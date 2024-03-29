// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rezervacija.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rezervacija _$RezervacijaFromJson(Map<String, dynamic> json) => Rezervacija(
      json['rezervacijaId'] as int,
      DateTime.parse(json['datum'] as String),
      DateTime.parse(json['vrijeme'] as String),
      json['status'] as bool?,
      json['korisnikId'] as int,
      json['uposlenikId'] as int,
      json['uslugaId'] as int,
    );

Map<String, dynamic> _$RezervacijaToJson(Rezervacija instance) =>
    <String, dynamic>{
      'rezervacijaId': instance.rezervacijaId,
      'datum': instance.datum.toIso8601String(),
      'vrijeme': instance.vrijeme.toIso8601String(),
      'status': instance.status,
      'korisnikId': instance.korisnikId,
      'uposlenikId': instance.uposlenikId,
      'uslugaId': instance.uslugaId,
    };
