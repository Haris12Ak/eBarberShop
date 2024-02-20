// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proizvodi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Proizvodi _$ProizvodiFromJson(Map<String, dynamic> json) => Proizvodi(
      json['proizvodiId'] as int,
      (json['cijena'] as num).toDouble(),
      json['naziv'] as String,
      json['sifra'] as String,
      json['opis'] as String?,
      json['slika'] as String?,
      json['status'] as bool?,
      json['vrstaProizvodaId'] as int,
      json['vrstaProizvodaNaziv'] as String?,
    );

Map<String, dynamic> _$ProizvodiToJson(Proizvodi instance) => <String, dynamic>{
      'proizvodiId': instance.proizvodiId,
      'cijena': instance.cijena,
      'naziv': instance.naziv,
      'sifra': instance.sifra,
      'opis': instance.opis,
      'slika': instance.slika,
      'status': instance.status,
      'vrstaProizvodaId': instance.vrstaProizvodaId,
      'vrstaProizvodaNaziv': instance.vrstaProizvodaNaziv,
    };
