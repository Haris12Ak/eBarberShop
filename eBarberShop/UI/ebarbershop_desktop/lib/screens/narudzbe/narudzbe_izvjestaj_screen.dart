import 'dart:io';

import 'package:ebarbershop_desktop/models/narudzbe/izvjestaj/izvjestaj_narudzbe.dart';
import 'package:ebarbershop_desktop/models/narudzbe/izvjestaj/narudzba_info.dart';
import 'package:ebarbershop_desktop/providers/narudzbe_provider.dart';
import 'package:ebarbershop_desktop/utils/util.dart';
import 'package:ebarbershop_desktop/widgets/master_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
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

    getIzvjestaj();
  }

  Future getIzvjestaj() async {
    try {
      izvjestajResult = await _narudzbeProvider.getIzvjestajNarudzbe(filter: {
        "datumOd": widget.datumOd,
        "datumDo": widget.datumDo,
      });

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
              child: const Text("Close"),
            ),
          ],
        ),
      );
    }
  }

  Future<void> generatePDF() async {
    final pdf = pw.Document();

    final img = await rootBundle.load('assets/images/logo.png');
    final imageBytes = img.buffer.asUint8List();

    pw.Image image1 = pw.Image(pw.MemoryImage(imageBytes));

    pdf.addPage(
      pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return [
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Container(
                    color: PdfColor.fromHex("#DEDEDE"),
                    padding: const pw.EdgeInsets.all(8.0),
                    child: pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Container(
                            alignment: pw.Alignment.topLeft,
                            height: 65,
                            width: 65,
                            child: image1,
                          ),
                          pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.end,
                              children: [
                                pw.Text('Datum i vrijeme',
                                    style: pw.TextStyle(
                                        color: PdfColor.fromHex("#2B2B2B"))),
                                pw.SizedBox(height: 2.0),
                                pw.Text(formatDate(DateTime.now()),
                                    style: pw.TextStyle(
                                        color: PdfColor.fromHex("#424242"))),
                              ]),
                        ]),
                  ),
                  pw.SizedBox(height: 10.0),
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
                  pw.SizedBox(height: 20.0),
                  pw.Container(
                    color: PdfColor.fromHex("#EBEBEB"),
                    padding: const pw.EdgeInsets.all(5.0),
                    child: pw.RichText(
                      text: pw.TextSpan(children: [
                        const pw.TextSpan(text: 'Najvise prodavan proizvod: '),
                        pw.TextSpan(
                            text: izvjestajResult!.najviseProdavaniProizvod,
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ]),
                    ),
                  ),
                  pw.SizedBox(height: 15.0),
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
                  pw.Divider(height: 5.0, color: PdfColor.fromHex("#9E9E9E")),
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
                                color: PdfColor.fromHex("#9E9E9E")),
                          ),
                          pw.Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
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

    final directory = await getDownloadsDirectory();
    final path =
        '${directory?.path}/${"Izvještaj_narudzbi ${DateTime.now().year}_${DateTime.now().month}_${DateTime.now().day}_${DateTime.now().millisecondsSinceEpoch}.pdf"}';
    final file = File(path);
    await file.writeAsBytes(await pdf.save());

    // ignore: use_build_context_synchronously
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.blue.shade50,
              title: const Icon(
                Icons.save_alt,
                size: 38,
              ),
              content: Text(
                'PDF has been saved to: $path',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();

                      OpenFile.open(file.path);
                    },
                    child: const Text(
                      'OK',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ))
              ],
            ));
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
                      await generatePDF();
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.red.shade200,
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
                  height: 10.0,
                ),
                Container(
                  color: Colors.grey[100],
                  padding: const EdgeInsets.all(10.0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                            text: 'Najviše prodavan proizvod: ',
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w400)),
                        TextSpan(
                            text: izvjestajResult!.najviseProdavaniProizvod,
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
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
