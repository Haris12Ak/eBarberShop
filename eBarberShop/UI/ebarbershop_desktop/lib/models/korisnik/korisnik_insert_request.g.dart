// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'korisnik_insert_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KorisnikInsertRequest _$KorisnikInsertRequestFromJson(
        Map<String, dynamic> json) =>
    KorisnikInsertRequest(
      json['ime'] as String,
      json['prezime'] as String,
      json['email'] as String,
      json['adresa'] as String?,
      json['brojTelefona'] as String?,
      json['korisnickoIme'] as String,
      json['lozinka'] as String,
      json['lozinkaPotvrda'] as String,
      json['status'] as bool?,
      json['slika'] as String?,
      json['gradId'] as int,
    );

Map<String, dynamic> _$KorisnikInsertRequestToJson(
        KorisnikInsertRequest instance) =>
    <String, dynamic>{
      'ime': instance.ime,
      'prezime': instance.prezime,
      'email': instance.email,
      'adresa': instance.adresa,
      'brojTelefona': instance.brojTelefona,
      'korisnickoIme': instance.korisnickoIme,
      'lozinka': instance.lozinka,
      'lozinkaPotvrda': instance.lozinkaPotvrda,
      'status': instance.status,
      'slika': instance.slika,
      'gradId': instance.gradId,
    };
