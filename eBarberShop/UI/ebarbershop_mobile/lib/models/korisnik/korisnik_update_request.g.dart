// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'korisnik_update_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KorisnikUpdateRequest _$KorisnikUpdateRequestFromJson(
        Map<String, dynamic> json) =>
    KorisnikUpdateRequest(
      json['ime'] as String,
      json['prezime'] as String,
      json['korisnickoIme'] as String,
      json['email'] as String,
      json['adresa'] as String?,
      json['brojTelefona'] as String?,
      json['status'] as bool?,
      json['slika'] as String?,
      json['gradId'] as int,
      json['lozinka'] as String?,
      json['lozinkaPotvrda'] as String?,
    );

Map<String, dynamic> _$KorisnikUpdateRequestToJson(
        KorisnikUpdateRequest instance) =>
    <String, dynamic>{
      'ime': instance.ime,
      'prezime': instance.prezime,
      'korisnickoIme': instance.korisnickoIme,
      'email': instance.email,
      'adresa': instance.adresa,
      'brojTelefona': instance.brojTelefona,
      'status': instance.status,
      'slika': instance.slika,
      'gradId': instance.gradId,
      'lozinka': instance.lozinka,
      'lozinkaPotvrda': instance.lozinkaPotvrda,
    };
