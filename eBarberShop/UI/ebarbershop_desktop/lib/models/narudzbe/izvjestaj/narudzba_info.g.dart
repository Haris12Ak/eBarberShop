// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'narudzba_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NarudzbaIfno _$NarudzbaIfnoFromJson(Map<String, dynamic> json) => NarudzbaIfno(
      DateTime.parse(json['datumNarudzbe'] as String),
      (json['ukupanIznos'] as num).toDouble(),
      (json['narudzbe'] as List<dynamic>)
          .map((e) => ListOfNarudzbe.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NarudzbaIfnoToJson(NarudzbaIfno instance) =>
    <String, dynamic>{
      'datumNarudzbe': instance.datumNarudzbe.toIso8601String(),
      'ukupanIznos': instance.ukupanIznos,
      'narudzbe': instance.narudzbe,
    };
