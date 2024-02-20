import 'package:json_annotation/json_annotation.dart';

part 'proizvodi.g.dart';

@JsonSerializable()
class Proizvodi {
  int proizvodiId;
  double cijena;
  String naziv;
  String sifra;
  String? opis;
  String? slika;
  bool? status;
  int vrstaProizvodaId;
  String? vrstaProizvodaNaziv;

  Proizvodi(this.proizvodiId, this.cijena, this.naziv, this.sifra, this.opis, this.slika, this.status, this.vrstaProizvodaId, this.vrstaProizvodaNaziv);

  factory Proizvodi.fromJson(Map<String, dynamic> json) =>
      _$ProizvodiFromJson(json);

  Map<String, dynamic> toJson() => _$ProizvodiToJson(this);
}