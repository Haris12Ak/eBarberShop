import 'package:ebarbershop_desktop/models/narudzbe/izvjestaj/list_of_narudzbe.dart';

import 'package:json_annotation/json_annotation.dart';

part 'narudzba_info.g.dart';

@JsonSerializable()
class NarudzbaIfno {
DateTime datumNarudzbe;
double ukupanIznos;
List<ListOfNarudzbe> narudzbe = [];

NarudzbaIfno(this.datumNarudzbe, this.ukupanIznos, this.narudzbe);

 factory NarudzbaIfno.fromJson(Map<String, dynamic> json) =>
      _$NarudzbaIfnoFromJson(json);

  Map<String, dynamic> toJson() => _$NarudzbaIfnoToJson(this);
}

