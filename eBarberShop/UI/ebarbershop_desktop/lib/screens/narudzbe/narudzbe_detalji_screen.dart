import 'package:ebarbershop_desktop/models/narudzbe/narudzbe.dart';
import 'package:ebarbershop_desktop/models/narudzbeDetalji/narudzbe_detalji.dart';
import 'package:ebarbershop_desktop/models/search_result.dart';
import 'package:ebarbershop_desktop/providers/narudzbe_detalji_provider.dart';
import 'package:ebarbershop_desktop/utils/util.dart';
import 'package:ebarbershop_desktop/widgets/master_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class NarudzbeDetaljiScreen extends StatefulWidget {
  Narudzbe narudzba;
  NarudzbeDetaljiScreen({super.key, required this.narudzba});

  @override
  State<NarudzbeDetaljiScreen> createState() => _NarudzbeDetaljiScreenState();
}

class _NarudzbeDetaljiScreenState extends State<NarudzbeDetaljiScreen> {
  late NarudzbeDetaljiProvider _narudzbeDetaljiProvider;
  SearchResult<NarudzbeDetalji>? narudzbeDetaljiResult;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    _narudzbeDetaljiProvider = context.read<NarudzbeDetaljiProvider>();

    fetchNarudzbeDetalji();
  }

  Future fetchNarudzbeDetalji() async {
    narudzbeDetaljiResult = await _narudzbeDetaljiProvider.GetNarudzbeDetalji(
        widget.narudzba.narudzbeId);

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
        title: 'Detalji',
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Broj Narudžbe: ${widget.narudzba.brojNarudzbe}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.solid,
                        color: Colors.black87),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  _buildInformacijeKupca(),
                  const SizedBox(
                    height: 20.0,
                  ),
                  _buildInformacijeNarudzbe(),
                  const Divider(
                    height: 50.0,
                  ),
                  _buildListaProizvoda(),
                ],
              ));
  }

  Stack _buildListaProizvoda() {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(25.0),
          margin: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          child: SingleChildScrollView(
            child: DataTable(
              dataTextStyle: const TextStyle(fontSize: 16.0),
              decoration: const BoxDecoration(color: Colors.white70),
              columns: const <DataColumn>[
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Rb.',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.black54),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Proizvod',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.black54),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Sifra',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.black54),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Količina',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.black54),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Cijena',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.black54),
                    ),
                  ),
                ),
              ],
              rows: narudzbeDetaljiResult?.result
                      .asMap()
                      .map((index, NarudzbeDetalji e) => MapEntry(
                          index,
                          DataRow(cells: <DataCell>[
                            DataCell(Text((index + 1).toString())),
                            DataCell(Text(e.nazivProizvoda ?? "")),
                            DataCell(Text(e.sifraProizvoda ?? "")),
                            DataCell(Text(e.kolicina.toString())),
                            DataCell(
                                Text('${formatNumber(e.cijenaProizvoda)} KM')),
                          ])))
                      .values
                      .toList() ??
                  [],
            ),
          ),
        ),
        Positioned(
            top: -2.0,
            left: 25.0,
            child: Container(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                color: Colors.white,
                child: const Text(
                  'Proizvodi',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                ))),
      ],
    );
  }

  Stack _buildInformacijeNarudzbe() {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(25.0),
          margin: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    'Datum narudžbe:',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.black54),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    formatDate(widget.narudzba.datumNarudzbe),
                    style: const TextStyle(fontSize: 18.0),
                  )
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  const Text(
                    'Ukupno artikla:',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.black54),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    '${narudzbeDetaljiResult!.count}',
                    style: const TextStyle(fontSize: 18.0),
                  )
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  const Text(
                    'Ukupan iznos:',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.black54),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    '${widget.narudzba.ukupanIznos} KM',
                    style: const TextStyle(fontSize: 18.0),
                  )
                ],
              ),
            ],
          ),
        ),
        Positioned(
            top: -2.0,
            left: 25.0,
            child: Container(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                color: Colors.white,
                child: const Text(
                  'Informacije narudžbe',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                ))),
      ],
    );
  }

  Stack _buildInformacijeKupca() {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(25.0),
          margin: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    'Ime i prezime:',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.black54),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    '${widget.narudzba.imeKorisnika} ${widget.narudzba.prezimeKorisnika}',
                    style: const TextStyle(fontSize: 18.0),
                  )
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  const Text(
                    'Email:',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.black54),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    widget.narudzba.emailKorisnika ?? "",
                    style: const TextStyle(fontSize: 18.0),
                  )
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  const Text(
                    'Adresa:',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.black54),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    widget.narudzba.adersaKorisnika ?? "",
                    style: const TextStyle(fontSize: 18.0),
                  )
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  const Text(
                    'Kontakt telefon:',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.black54),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    widget.narudzba.brojTelefonaKorisnika ?? "",
                    style: const TextStyle(fontSize: 18.0),
                  )
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  const Text(
                    'Mjesto boravka:',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.black54),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    widget.narudzba.mjestoBoravkaKorisnika ?? "",
                    style: const TextStyle(fontSize: 18.0),
                  )
                ],
              ),
            ],
          ),
        ),
        Positioned(
            top: -2.0,
            left: 25.0,
            child: Container(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                color: Colors.white,
                child: const Text(
                  'Informacije kupca',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                ))),
      ],
    );
  }
}
