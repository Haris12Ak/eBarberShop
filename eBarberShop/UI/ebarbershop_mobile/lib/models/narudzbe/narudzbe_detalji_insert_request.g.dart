// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'narudzbe_detalji_insert_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NarudzbeDetaljiInsertRequest _$NarudzbeDetaljiInsertRequestFromJson(
        Map<String, dynamic> json) =>
    NarudzbeDetaljiInsertRequest(
      json['kolicina'] as int,
      json['narudzbaId'] as int,
      json['proizvodId'] as int,
    );

Map<String, dynamic> _$NarudzbeDetaljiInsertRequestToJson(
        NarudzbeDetaljiInsertRequest instance) =>
    <String, dynamic>{
      'kolicina': instance.kolicina,
      'narudzbaId': instance.narudzbaId,
      'proizvodId': instance.proizvodId,
    };
