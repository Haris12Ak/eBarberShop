// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'termini_korisnika_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TerminiKorisnikaInfo _$TerminiKorisnikaInfoFromJson(
        Map<String, dynamic> json) =>
    TerminiKorisnikaInfo(
      json['rezervacijaId'] as int,
      DateTime.parse(json['datum'] as String),
      DateTime.parse(json['vrijeme'] as String),
      json['isAktivna'] as bool,
    );

Map<String, dynamic> _$TerminiKorisnikaInfoToJson(
        TerminiKorisnikaInfo instance) =>
    <String, dynamic>{
      'rezervacijaId': instance.rezervacijaId,
      'datum': instance.datum.toIso8601String(),
      'vrijeme': instance.vrijeme.toIso8601String(),
      'isAktivna': instance.isAktivna,
    };
