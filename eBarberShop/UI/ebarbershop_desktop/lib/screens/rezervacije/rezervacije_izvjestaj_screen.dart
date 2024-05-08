import 'dart:io';

import 'package:ebarbershop_desktop/models/rezervacije/izvjestaj/izvjestaj_rezervacije.dart';
import 'package:ebarbershop_desktop/providers/rezervacija_provider.dart';
import 'package:ebarbershop_desktop/utils/util.dart';
import 'package:ebarbershop_desktop/widgets/master_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:pdf/widgets.dart' as pw;

// ignore: must_be_immutable
class RezervacijeIzvjestajScreen extends StatefulWidget {
  DateTime? datum;
  RezervacijeIzvjestajScreen({super.key, this.datum});

  @override
  State<RezervacijeIzvjestajScreen> createState() =>
      _RezervacijeIzvjestajScreenState();
}

class _RezervacijeIzvjestajScreenState
    extends State<RezervacijeIzvjestajScreen> {
  late RezervacijaProvider _rezervacijaProvider;
  late IzvjestajRezervacije izvjestaj;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    _rezervacijaProvider = context.read<RezervacijaProvider>();

    getIzvjestaj();
  }

  Future getIzvjestaj() async {
    try {
      izvjestaj = await _rezervacijaProvider
          .getIzvjestajRezervacije(filter: {'Datum': widget.datum});

      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    } on Exception catch (e) {
      // ignore: use_build_context_synchronously
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text("Error"),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  Future<void> generatePDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        build: (pw.Context context) {
          return [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.stretch,
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Text('Izvjestaj za prethodni dan',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 8.0),
                pw.Text(
                    'Ukupno rezervacija: ${izvjestaj.brojRezervacijaPrethodnogDana.toString()}'),
                pw.SizedBox(height: 5.0),
                pw.Text(
                    'Ukupna zarada: ${formatNumber(izvjestaj.zaradaPrethodnogDana)} KM'),
                pw.Divider(height: 10.0),
                pw.SizedBox(height: 15.0),
                pw.Text('Izvjestaj za prethodnu sedmicu',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 8.0),
                pw.Text(
                    'Ukupno rezervacija: ${izvjestaj.brojRezervacijaPrethodneSedmice.toString()}'),
                pw.SizedBox(height: 5.0),
                pw.Text(
                    'Ukupna zarada: ${formatNumber(izvjestaj.zaradaPrethodneSemice)} KM'),
                pw.Divider(height: 10.0),
                pw.SizedBox(height: 15.0),
                pw.Text('Izvjestaj za prethodni mjesec',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 8.0),
                pw.Text(
                    'Ukupno rezervacija: ${izvjestaj.brojRezervacijaPrethodnogMjeseca.toString()}'),
                pw.SizedBox(height: 5.0),
                pw.Text(
                    'Ukupna zarada: ${formatNumber(izvjestaj.zaradaPrethodnogMjeseca)} KM'),
                pw.Divider(height: 10.0),
                pw.SizedBox(height: 15.0),
                pw.Text(
                    widget.datum != null
                        ? 'Pregled izvjestaja rezervacija kreiranih u intervalu datuma: ${getDateFormat(widget.datum)} - ${getDateFormat(DateTime.now())}'
                        : 'Pregled izvjestaja za sve rezervacije',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 8.0),
                pw.Text(
                    'Ukupno rezervacija: ${izvjestaj.ukupnoRezervacija.toString()}'),
                pw.SizedBox(height: 5.0),
                pw.Text(
                    'Aktivnih rezervacija: ${izvjestaj.ukupnoAktivnihRezervacija.toString()}'),
                pw.SizedBox(height: 5.0),
                pw.Text(
                    'Neaktivnih rezervacija: ${izvjestaj.ukupnoNeaktivnihRezervacija.toString()}'),
                pw.SizedBox(height: 8.0),
                pw.Text('Aktivnih usluga: ${izvjestaj.brojUsluga.toString()}'),
                pw.SizedBox(height: 8.0),
                pw.Text(
                    'Uposlenik sa najvise rezervacija: ${izvjestaj.uposlenikSaNajviseRezervacija}'),
                pw.SizedBox(height: 5.0),
                pw.Text(
                    'Usluga sa najvise rezervacija: ${izvjestaj.uslugaSaNajviseRezervacija}'),
                pw.SizedBox(height: 8.0),
                pw.Text(
                    'Ukupna zarada: ${formatNumber(izvjestaj.ukupnaZarada)} KM'),
                pw.Divider(height: 10.0),
              ],
            ),
          ];
        },
      ),
    );

    // Save the PDF to a file
    final output =
        'Izvještaj_narudzbi_${DateTime.now().millisecondsSinceEpoch}.pdf';
    final file = File(output);
    await file.writeAsBytes(await pdf.save());
    OpenFile.open(file.path);
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: 'Izvještaj rezervacija',
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildIzvjestajUPrethodnihMjesecDana(),
                const Divider(color: Colors.black54),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  widget.datum != null
                      ? 'Pregled izvještaja rezervacija kreiranih u intervalu datuma: ${getDateFormat(widget.datum)} - ${getDateFormat(DateTime.now())}'
                      : 'Pregled izvještaja za sve rezervacije',
                  style: const TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Ukupno rezervacija:',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Text(
                      izvjestaj.ukupnoRezervacija.toString(),
                      style: const TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Aktivnih rezervacija:',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Text(
                      izvjestaj.ukupnoAktivnihRezervacija.toString(),
                      style: const TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Neaktivnih rezervacija:',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Text(
                      izvjestaj.ukupnoNeaktivnihRezervacija.toString(),
                      style: const TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Aktivnih usluga:',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Text(
                      izvjestaj.brojUsluga.toString(),
                      style: const TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Uposlenik sa najviše rezervacija:',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Text(
                      izvjestaj.uposlenikSaNajviseRezervacija,
                      style: const TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Usluga sa najviše rezervacija:',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Text(
                      izvjestaj.uslugaSaNajviseRezervacija,
                      style: const TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Ukupna zarada:',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Text(
                      '${formatNumber(izvjestaj.ukupnaZarada)} KM',
                      style: const TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(height: 15.0),
                Align(
                  alignment: Alignment.topRight,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      bool open = await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Potvrda'),
                            content:
                                const Text('Da li želite otvoriti PDF file?'),
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
                      shape: const BeveledRectangleBorder(
                          borderRadius: BorderRadius.zero),
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
              ],
            ),
    );
  }

  Container _buildIzvjestajUPrethodnihMjesecDana() {
    return Container(
      margin: const EdgeInsets.all(50.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              height: 180,
              decoration:
                  BoxDecoration(color: Colors.grey.shade400, boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade500,
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: const Offset(5, 5))
              ]),
              child: Column(
                children: [
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(width: 12.0),
                      Icon(
                        Icons.date_range_outlined,
                        size: 35.0,
                      ),
                      SizedBox(width: 20.0),
                      Text(
                        'Izvještaj za prethodni dan',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const Divider(
                    height: 30.0,
                    color: Colors.white,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'Ukupno rezervacija:',
                        style: TextStyle(
                            fontSize: 17.0, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Text(
                        izvjestaj.brojRezervacijaPrethodnogDana.toString(),
                        style: const TextStyle(
                            fontSize: 17.0, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'Ukupna zarada:',
                        style: TextStyle(
                            fontSize: 17.0, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Text(
                        '${formatNumber(izvjestaj.zaradaPrethodnogDana)} KM',
                        style: const TextStyle(
                            fontSize: 17.0, fontWeight: FontWeight.w500),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(width: 65.0),
          Expanded(
            child: Container(
              decoration:
                  BoxDecoration(color: Colors.grey.shade400, boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade500,
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: const Offset(5, 5))
              ]),
              padding: const EdgeInsets.all(10.0),
              height: 180,
              child: Column(
                children: [
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(width: 12.0),
                      Icon(
                        Icons.date_range_outlined,
                        size: 35.0,
                      ),
                      SizedBox(width: 20.0),
                      Text(
                        'Izvještaj za prethodnu sedmicu',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const Divider(
                    height: 30.0,
                    color: Colors.white,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'Ukupno rezervacija:',
                        style: TextStyle(
                            fontSize: 17.0, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Text(
                        izvjestaj.brojRezervacijaPrethodneSedmice.toString(),
                        style: const TextStyle(
                            fontSize: 17.0, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'Ukupna zarada:',
                        style: TextStyle(
                            fontSize: 17.0, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Text(
                        '${formatNumber(izvjestaj.zaradaPrethodneSemice)} KM',
                        style: const TextStyle(
                            fontSize: 17.0, fontWeight: FontWeight.w500),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(width: 65.0),
          Expanded(
            child: Container(
              decoration:
                  BoxDecoration(color: Colors.grey.shade400, boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade500,
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: const Offset(5, 5))
              ]),
              padding: const EdgeInsets.all(10.0),
              height: 180,
              child: Column(
                children: [
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(width: 12.0),
                      Icon(
                        Icons.date_range_outlined,
                        size: 35.0,
                      ),
                      SizedBox(width: 20.0),
                      Text(
                        'Izvještaj za prethodni mjesec',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const Divider(
                    height: 30.0,
                    color: Colors.white,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'Ukupno rezervacija:',
                        style: TextStyle(
                            fontSize: 17.0, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Text(
                        izvjestaj.brojRezervacijaPrethodnogMjeseca.toString(),
                        style: const TextStyle(
                            fontSize: 17.0, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'Ukupna zarada:',
                        style: TextStyle(
                            fontSize: 17.0, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Text(
                        '${formatNumber(izvjestaj.zaradaPrethodnogMjeseca)} KM',
                        style: const TextStyle(
                            fontSize: 17.0, fontWeight: FontWeight.w500),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
