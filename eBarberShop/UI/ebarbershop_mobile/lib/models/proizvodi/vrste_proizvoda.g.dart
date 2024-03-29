// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vrste_proizvoda.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VrsteProizvoda _$VrsteProizvodaFromJson(Map<String, dynamic> json) =>
    VrsteProizvoda(
      json['vrsteProizvodaId'] as int,
      json['naziv'] as String,
      json['opis'] as String?,
    );

Map<String, dynamic> _$VrsteProizvodaToJson(VrsteProizvoda instance) =>
    <String, dynamic>{
      'vrsteProizvodaId': instance.vrsteProizvodaId,
      'naziv': instance.naziv,
      'opis': instance.opis,
    };
