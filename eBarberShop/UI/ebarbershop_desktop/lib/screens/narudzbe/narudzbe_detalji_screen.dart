import 'dart:io';

import 'package:ebarbershop_desktop/models/narudzbe/narudzbe.dart';
import 'package:ebarbershop_desktop/models/narudzbeDetalji/narudzbe_detalji.dart';
import 'package:ebarbershop_desktop/models/search_result.dart';
import 'package:ebarbershop_desktop/providers/narudzbe_detalji_provider.dart';
import 'package:ebarbershop_desktop/utils/util.dart';
import 'package:ebarbershop_desktop/widgets/master_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:pdf/widgets.dart' as pw;

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

  Future<void> generatePDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(build: (context) {
        return [
          pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            crossAxisAlignment: pw.CrossAxisAlignment.stretch,
            children: [
              pw.Text(
                'Broj narudzbe: ${widget.narudzba.brojNarudzbe}',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                textAlign: pw.TextAlign.center,
              ),
              pw.SizedBox(height: 20.0),
              pw.Text('Informacije kupca',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.Divider(height: 20.0),
              pw.Row(
                children: [
                  pw.Text('Ime i prezime:'),
                  pw.SizedBox(width: 10.0),
                  pw.Text(
                      '${widget.narudzba.imeKorisnika} ${widget.narudzba.prezimeKorisnika}')
                ],
              ),
              pw.SizedBox(height: 5.0),
              pw.Row(
                children: [
                  pw.Text('Email:'),
                  pw.SizedBox(width: 10.0),
                  pw.Text(widget.narudzba.emailKorisnika ?? "")
                ],
              ),
              pw.SizedBox(height: 5.0),
              pw.Row(
                children: [
                  pw.Text('Adresa:'),
                  pw.SizedBox(width: 10.0),
                  pw.Text(widget.narudzba.adersaKorisnika ?? "")
                ],
              ),
              pw.SizedBox(height: 5.0),
              pw.Row(
                children: [
                  pw.Text('Kontakt telefon:'),
                  pw.SizedBox(width: 10.0),
                  pw.Text(widget.narudzba.brojTelefonaKorisnika ?? "")
                ],
              ),
              pw.SizedBox(height: 5.0),
              pw.Row(
                children: [
                  pw.Text('Mjesto boravka:'),
                  pw.SizedBox(width: 10.0),
                  pw.Text(widget.narudzba.mjestoBoravkaKorisnika ?? "")
                ],
              ),
              pw.SizedBox(height: 20.0),
              pw.Text('Informacije narudzbe',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.Divider(height: 20.0),
              pw.Row(
                children: [
                  pw.Text('Datum narudzbe:'),
                  pw.SizedBox(width: 10.0),
                  pw.Text(formatDate(widget.narudzba.datumNarudzbe))
                ],
              ),
              pw.SizedBox(height: 5.0),
              pw.Row(
                children: [
                  pw.Text('Ukupno artikala:'),
                  pw.SizedBox(width: 10.0),
                  pw.Text(narudzbeDetaljiResult!.count.toString())
                ],
              ),
              pw.SizedBox(height: 5.0),
              pw.Row(
                children: [
                  pw.Text('Ukupan iznos:'),
                  pw.SizedBox(width: 10.0),
                  pw.Text('${formatNumber(widget.narudzba.ukupanIznos)} KM')
                ],
              ),
              pw.SizedBox(height: 20.0),
              pw.Text('Proizvodi',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.Divider(height: 20.0),
              pw.Table(
                children: [
                  pw.TableRow(
                    children: [
                      pw.Container(
                        padding: const pw.EdgeInsets.all(5.0),
                        child: pw.Text(
                          'Rb.',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                      pw.Container(
                        padding: const pw.EdgeInsets.all(5.0),
                        child: pw.Text(
                          'Proizvod',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                      pw.Container(
                        padding: const pw.EdgeInsets.all(5.0),
                        child: pw.Text(
                          'Sifra',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                      pw.Container(
                        padding: const pw.EdgeInsets.all(5.0),
                        child: pw.Text(
                          'Kolicina',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                      pw.Container(
                        padding: const pw.EdgeInsets.all(5.0),
                        child: pw.Text(
                          'Cijena',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  for (int i = 0; i < narudzbeDetaljiResult!.result.length; i++)
                    pw.TableRow(
                      children: [
                        pw.Container(
                          padding: const pw.EdgeInsets.all(5.0),
                          child: pw.Text('${i + 1}'),
                        ),
                        pw.Container(
                          padding: const pw.EdgeInsets.all(5.0),
                          child: pw.Text(
                              narudzbeDetaljiResult!.result[i].nazivProizvoda ??
                                  ""),
                        ),
                        pw.Container(
                          padding: const pw.EdgeInsets.all(5.0),
                          child: pw.Text(
                              narudzbeDetaljiResult!.result[i].sifraProizvoda ??
                                  ""),
                        ),
                        pw.Container(
                          padding: const pw.EdgeInsets.all(5.0),
                          child: pw.Text(narudzbeDetaljiResult!
                              .result[i].kolicina
                              .toString()),
                        ),
                        pw.Container(
                          padding: const pw.EdgeInsets.all(5.0),
                          child: pw.Text(
                              '${formatNumber(narudzbeDetaljiResult!.result[i].cijenaProizvoda)} KM'),
                        ),
                        pw.SizedBox(height: 10.0)
                      ],
                    ),
                ],
              ),
            ],
          ),
        ];
      }),
    );

    // Save the PDF to a file
    final output =
        '${widget.narudzba.brojNarudzbe}_${DateTime.now().millisecondsSinceEpoch}.pdf';
    final file = File(output);
    await file.writeAsBytes(await pdf.save());
    OpenFile.open(file.path);
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'Broj Narudžbe: ${widget.narudzba.brojNarudzbe}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.solid,
                        color: Colors.black87),
                  ),
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
                const SizedBox(
                  height: 20.0,
                ),
                _buildSaveToPdfFile(context),
              ],
            ),
    );
  }

  Container _buildSaveToPdfFile(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 15.0),
      child: Align(
        alignment: Alignment.topRight,
        child: ElevatedButton.icon(
          onPressed: () async {
            bool open = await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Potvrda'),
                  content: const Text('Da li želite otvoriti PDF file?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: const Text('DA'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: const Text('NE'),
                    ),
                  ],
                );
              },
            );

            if (open) {
              await generatePDF();
            }
          },
          style: ElevatedButton.styleFrom(
            elevation: 0.0,
            foregroundColor: Colors.black,
            backgroundColor: Colors.grey.shade200,
            padding: const EdgeInsets.all(18.0),
            shape:
                const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
          ),
          icon: const Image(
            image: AssetImage('assets/images/pdf-40.png'),
            width: 30,
            height: 30,
          ),
          label: const Text(
            'Snimi u PDF file',
            style: TextStyle(fontSize: 15),
          ),
        ),
      ),
    );
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
