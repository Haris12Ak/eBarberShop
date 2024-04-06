// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'izvjestaj_rezervacije.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IzvjestajRezervacije _$IzvjestajRezervacijeFromJson(
        Map<String, dynamic> json) =>
    IzvjestajRezervacije(
      json['ukupnoRezervacija'] as int,
      json['ukupnoAktivnihRezervacija'] as int,
      json['ukupnoNeaktivnihRezervacija'] as int,
      (json['zaradaPrethodnogDana'] as num).toDouble(),
      (json['zaradaPrethodneSemice'] as num).toDouble(),
      (json['zaradaPrethodnogMjeseca'] as num).toDouble(),
      json['brojRezervacijaPrethodnogDana'] as int,
      json['brojRezervacijaPrethodneSedmice'] as int,
      json['brojRezervacijaPrethodnogMjeseca'] as int,
      json['brojUsluga'] as int,
      json['uposlenikSaNajviseRezervacija'] as String,
      json['uslugaSaNajviseRezervacija'] as String,
      (json['ukupnaZarada'] as num).toDouble(),
    );

Map<String, dynamic> _$IzvjestajRezervacijeToJson(
        IzvjestajRezervacije instance) =>
    <String, dynamic>{
      'ukupnoRezervacija': instance.ukupnoRezervacija,
      'ukupnoAktivnihRezervacija': instance.ukupnoAktivnihRezervacija,
      'ukupnoNeaktivnihRezervacija': instance.ukupnoNeaktivnihRezervacija,
      'zaradaPrethodnogDana': instance.zaradaPrethodnogDana,
      'zaradaPrethodneSemice': instance.zaradaPrethodneSemice,
      'zaradaPrethodnogMjeseca': instance.zaradaPrethodnogMjeseca,
      'brojRezervacijaPrethodnogDana': instance.brojRezervacijaPrethodnogDana,
      'brojRezervacijaPrethodneSedmice':
          instance.brojRezervacijaPrethodneSedmice,
      'brojRezervacijaPrethodnogMjeseca':
          instance.brojRezervacijaPrethodnogMjeseca,
      'brojUsluga': instance.brojUsluga,
      'uposlenikSaNajviseRezervacija': instance.uposlenikSaNajviseRezervacija,
      'uslugaSaNajviseRezervacija': instance.uslugaSaNajviseRezervacija,
      'ukupnaZarada': instance.ukupnaZarada,
    };
