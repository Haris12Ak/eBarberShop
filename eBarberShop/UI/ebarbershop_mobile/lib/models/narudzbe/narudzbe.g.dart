// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'narudzbe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Narudzbe _$NarudzbeFromJson(Map<String, dynamic> json) => Narudzbe(
      json['narudzbeId'] as int,
      json['brojNarudzbe'] as String,
      DateTime.parse(json['datumNarudzbe'] as String),
      (json['ukupanIznos'] as num).toDouble(),
      json['status'] as bool,
      json['otkazano'] as bool?,
      json['korisnikId'] as int,
    );

Map<String, dynamic> _$NarudzbeToJson(Narudzbe instance) => <String, dynamic>{
      'narudzbeId': instance.narudzbeId,
      'brojNarudzbe': instance.brojNarudzbe,
      'datumNarudzbe': instance.datumNarudzbe.toIso8601String(),
      'ukupanIznos': instance.ukupanIznos,
      'status': instance.status,
      'otkazano': instance.otkazano,
      'korisnikId': instance.korisnikId,
    };
