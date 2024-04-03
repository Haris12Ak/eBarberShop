import 'dart:io';

import 'package:ebarbershop_desktop/models/narudzbe/izvjestaj/izvjestaj_narudzbe.dart';
import 'package:ebarbershop_desktop/models/narudzbe/izvjestaj/narudzba_info.dart';
import 'package:ebarbershop_desktop/providers/narudzbe_provider.dart';
import 'package:ebarbershop_desktop/utils/util.dart';
import 'package:ebarbershop_desktop/widgets/master_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:pdf/widgets.dart' as pw;

// ignore: must_be_immutable
class NarudzbeIzvjestajScreen extends StatefulWidget {
  DateTime? datumOd;
  DateTime? datumDo;
  NarudzbeIzvjestajScreen({super.key, this.datumOd, this.datumDo});

  @override
  State<NarudzbeIzvjestajScreen> createState() =>
      _NarudzbeIzvjestajScreenState();
}

class _NarudzbeIzvjestajScreenState extends State<NarudzbeIzvjestajScreen> {
  late NarudzbeProvider _narudzbeProvider;
  IzvjestajNarudzbe? izvjestajResult;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    _narudzbeProvider = context.read<NarudzbeProvider>();

    getIzvjestj();
  }

  Future getIzvjestj() async {
    izvjestajResult = await _narudzbeProvider.getIzvjestajNarudzbe(filter: {
      "datumOd": widget.datumOd,
      "datumDo": widget.datumDo,
    });

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> generatePDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(build: (pw.Context context) {
        return [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.stretch,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(
                'Izvjestaj narudzbi',
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 10.0),
              pw.Text(
                  widget.datumOd != null && widget.datumOd != null
                      ? '${formatDate1(widget.datumOd)} - ${formatDate1(widget.datumDo)}'
                      : 'Pregled izvjestaja za sve narudzbe',
                  textAlign: pw.TextAlign.center),
              pw.SizedBox(height: 30.0),
              pw.Container(
                margin: const pw.EdgeInsets.only(left: 70.0),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Expanded(
                      child: pw.Text(
                        'Broj narudzbe',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Text(
                        'Kupac',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                    pw.Text(
                      'Iznos',
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              pw.Divider(
                height: 5.0,
              ),
              pw.ListView.builder(
                itemCount: izvjestajResult!.narudzbaInfo.length,
                itemBuilder: (context, index) {
                  NarudzbaIfno narudzbaInfo =
                      izvjestajResult!.narudzbaInfo[index];
                  return pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Text(
                        DateFormat('MMMM d y')
                            .format(narudzbaInfo.datumNarudzbe),
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      for (var item in narudzbaInfo.narudzbe)
                        pw.Container(
                          margin: const pw.EdgeInsets.only(left: 70.0),
                          padding: const pw.EdgeInsets.only(bottom: 3.0),
                          child: pw.Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Expanded(
                                child: pw.Text(
                                  item.brojNarudzbe,
                                ),
                              ),
                              pw.Expanded(
                                child: pw.Text(
                                  '${item.imeKorisnika} ${item.prezimeKorisnika}',
                                ),
                              ),
                              pw.Text(
                                '${formatNumber(item.naplata)} KM',
                              ),
                            ],
                          ),
                        ),
                      pw.Container(
                        margin: const pw.EdgeInsets.only(left: 70.0),
                        child: pw.Divider(
                          height: 10.0,
                        ),
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Container(
                            margin: const pw.EdgeInsets.only(left: 70.0),
                            child: pw.Text(
                              'Ukupno za ${DateFormat('MMMM d y').format(narudzbaInfo.datumNarudzbe)}:',
                              textAlign: pw.TextAlign.right,
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                          pw.Container(
                            child: pw.Text(
                              '${formatNumber(narudzbaInfo.ukupanIznos)} KM',
                              textAlign: pw.TextAlign.right,
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 20.0),
                    ],
                  );
                },
              ),
              pw.SizedBox(
                height: 10.0,
              ),
              pw.Container(
                padding: const pw.EdgeInsets.all(8.0),
                decoration: pw.BoxDecoration(border: pw.Border.all()),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'UKUPNO:',
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      '${formatNumber(izvjestajResult!.ukupno)} KM',
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ];
      }),
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
      title: 'Izvještaj',
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Izvještaj narudžbi',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Text(
                  widget.datumOd != null && widget.datumOd != null
                      ? '${formatDate1(widget.datumOd)} - ${formatDate1(widget.datumDo)}'
                      : 'Pregled izvještaja za sve narudžbe',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18.0),
                ),
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
                const SizedBox(
                  height: 50.0,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 110.0, right: 110.0),
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          'Broj narudzbe',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.black54),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Kupac',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.black54),
                        ),
                      ),
                      Text(
                        'Iznos',
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.black54),
                      )
                    ],
                  ),
                ),
                const Divider(
                  height: 15.0,
                  color: Colors.black,
                ),
                if (izvjestajResult!.narudzbaInfo.isEmpty)
                  Container(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Center(
                      child: Text(
                        'Nema narudžbi za datume u intervalu: [ ${formatDate1(widget.datumOd)} - ${formatDate1(widget.datumDo)} ]',
                        style: const TextStyle(fontSize: 18.0),
                      ),
                    ),
                  )
                else
                  SingleChildScrollView(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: izvjestajResult!.narudzbaInfo.length,
                      itemBuilder: (BuildContext context, int index) {
                        NarudzbaIfno narudzbaInfo =
                            izvjestajResult!.narudzbaInfo[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat('MMMM d y')
                                  .format(narudzbaInfo.datumNarudzbe),
                              style: const TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.w600),
                            ),
                            for (var item in narudzbaInfo.narudzbe)
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 110.0, right: 110.0),
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        item.brojNarudzbe,
                                        style: const TextStyle(fontSize: 18.0),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        '${item.imeKorisnika} ${item.prezimeKorisnika}',
                                        style: const TextStyle(fontSize: 18.0),
                                      ),
                                    ),
                                    Text(
                                      '${formatNumber(item.naplata)} KM',
                                      style: const TextStyle(fontSize: 18.0),
                                    ),
                                  ],
                                ),
                              ),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 110.0, right: 110.0),
                              child: const Divider(
                                height: 20.0,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 110.0),
                                  child: Text(
                                    'Ukupno za ${DateFormat('MMMM d y').format(narudzbaInfo.datumNarudzbe)}:',
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(right: 110.0),
                                  child: Text(
                                    '${formatNumber(narudzbaInfo.ukupanIznos)} KM',
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                const SizedBox(
                  height: 50.0,
                ),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(border: Border.all()),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'UKUPNO:',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '${formatNumber(izvjestajResult!.ukupno)} KM',
                        style: const TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
