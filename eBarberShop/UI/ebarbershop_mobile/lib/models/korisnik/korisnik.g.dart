// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'korisnik.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Korisnik _$KorisnikFromJson(Map<String, dynamic> json) => Korisnik(
      json['korisniciId'] as int,
      json['ime'] as String,
      json['prezime'] as String,
      json['email'] as String?,
      json['adresa'] as String?,
      json['brojTelefona'] as String?,
      json['status'] as bool?,
      json['slika'] as String?,
      json['gradId'] as int,
    );

Map<String, dynamic> _$KorisnikToJson(Korisnik instance) => <String, dynamic>{
      'korisniciId': instance.korisniciId,
      'ime': instance.ime,
      'prezime': instance.prezime,
      'email': instance.email,
      'adresa': instance.adresa,
      'brojTelefona': instance.brojTelefona,
      'status': instance.status,
      'slika': instance.slika,
      'gradId': instance.gradId,
    };
