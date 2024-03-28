// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'narudzbe_detalji.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NarudzbeDetalji _$NarudzbeDetaljiFromJson(Map<String, dynamic> json) =>
    NarudzbeDetalji(
      json['narudzbeDetaljiId'] as int,
      json['kolicina'] as int,
      json['narudzbaId'] as int,
      json['proizvodId'] as int,
    );

Map<String, dynamic> _$NarudzbeDetaljiToJson(NarudzbeDetalji instance) =>
    <String, dynamic>{
      'narudzbeDetaljiId': instance.narudzbeDetaljiId,
      'kolicina': instance.kolicina,
      'narudzbaId': instance.narudzbaId,
      'proizvodId': instance.proizvodId,
    };
