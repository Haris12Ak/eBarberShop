// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recenzije_insert_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecenzijeInsertRequest _$RecenzijeInsertRequestFromJson(
        Map<String, dynamic> json) =>
    RecenzijeInsertRequest(
      json['sadrzaj'] as String,
      (json['ocjena'] as num).toDouble(),
      DateTime.parse(json['datumObjave'] as String),
      json['korisnikId'] as int,
    );

Map<String, dynamic> _$RecenzijeInsertRequestToJson(
        RecenzijeInsertRequest instance) =>
    <String, dynamic>{
      'sadrzaj': instance.sadrzaj,
      'ocjena': instance.ocjena,
      'datumObjave': instance.datumObjave.toIso8601String(),
      'korisnikId': instance.korisnikId,
    };
