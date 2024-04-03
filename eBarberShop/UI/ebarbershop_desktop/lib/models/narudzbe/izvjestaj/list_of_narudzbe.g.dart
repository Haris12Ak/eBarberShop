// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_of_narudzbe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListOfNarudzbe _$ListOfNarudzbeFromJson(Map<String, dynamic> json) =>
    ListOfNarudzbe(
      json['brojNarudzbe'] as String,
      (json['naplata'] as num).toDouble(),
      json['korisnikId'] as int,
      json['imeKorisnika'] as String?,
      json['prezimeKorisnika'] as String?,
    );

Map<String, dynamic> _$ListOfNarudzbeToJson(ListOfNarudzbe instance) =>
    <String, dynamic>{
      'brojNarudzbe': instance.brojNarudzbe,
      'naplata': instance.naplata,
      'korisnikId': instance.korisnikId,
      'imeKorisnika': instance.imeKorisnika,
      'prezimeKorisnika': instance.prezimeKorisnika,
    };
