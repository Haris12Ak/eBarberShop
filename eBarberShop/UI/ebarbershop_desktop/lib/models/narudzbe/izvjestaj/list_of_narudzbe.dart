import 'package:json_annotation/json_annotation.dart';

part 'list_of_narudzbe.g.dart';

@JsonSerializable()
class ListOfNarudzbe {
  String brojNarudzbe;
  double naplata;
  int korisnikId;
  String? imeKorisnika;
  String? prezimeKorisnika;

  ListOfNarudzbe(this.brojNarudzbe, this.naplata, this.korisnikId, this.imeKorisnika, this.prezimeKorisnika);

   factory ListOfNarudzbe.fromJson(Map<String, dynamic> json) =>
      _$ListOfNarudzbeFromJson(json);

  Map<String, dynamic> toJson() => _$ListOfNarudzbeToJson(this);
}