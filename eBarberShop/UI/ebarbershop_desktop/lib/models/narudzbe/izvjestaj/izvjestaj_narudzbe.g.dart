// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'izvjestaj_narudzbe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IzvjestajNarudzbe _$IzvjestajNarudzbeFromJson(Map<String, dynamic> json) =>
    IzvjestajNarudzbe(
      (json['ukupno'] as num).toDouble(),
      (json['narudzbaInfo'] as List<dynamic>)
          .map((e) => NarudzbaIfno.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$IzvjestajNarudzbeToJson(IzvjestajNarudzbe instance) =>
    <String, dynamic>{
      'ukupno': instance.ukupno,
      'narudzbaInfo': instance.narudzbaInfo,
    };
