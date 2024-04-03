import 'package:ebarbershop_desktop/models/narudzbe/izvjestaj/narudzba_info.dart';

import 'package:json_annotation/json_annotation.dart';

part 'izvjestaj_narudzbe.g.dart';

@JsonSerializable()
class IzvjestajNarudzbe {
  double ukupno;
  List<NarudzbaIfno> narudzbaInfo = [];

  IzvjestajNarudzbe(this.ukupno, this.narudzbaInfo);

  factory IzvjestajNarudzbe.fromJson(Map<String, dynamic> json) =>
      _$IzvjestajNarudzbeFromJson(json);

  Map<String, dynamic> toJson() => _$IzvjestajNarudzbeToJson(this);
}
