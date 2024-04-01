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
      json['imeKorisnika'] as String?,
      json['prezimeKorisnika'] as String?,
      json['emailKorisnika'] as String?,
      json['adersaKorisnika'] as String?,
      json['brojTelefonaKorisnika'] as String?,
      json['mjestoBoravkaKorisnika'] as String?,
    );

Map<String, dynamic> _$NarudzbeToJson(Narudzbe instance) => <String, dynamic>{
      'narudzbeId': instance.narudzbeId,
      'brojNarudzbe': instance.brojNarudzbe,
      'datumNarudzbe': instance.datumNarudzbe.toIso8601String(),
      'ukupanIznos': instance.ukupanIznos,
      'status': instance.status,
      'otkazano': instance.otkazano,
      'korisnikId': instance.korisnikId,
      'imeKorisnika': instance.imeKorisnika,
      'prezimeKorisnika': instance.prezimeKorisnika,
      'emailKorisnika': instance.emailKorisnika,
      'adersaKorisnika': instance.adersaKorisnika,
      'brojTelefonaKorisnika': instance.brojTelefonaKorisnika,
      'mjestoBoravkaKorisnika': instance.mjestoBoravkaKorisnika,
    };
