import 'dart:io';

import 'package:ebarbershop_desktop/models/narudzbe/narudzbe.dart';
import 'package:ebarbershop_desktop/models/narudzbeDetalji/narudzbe_detalji.dart';
import 'package:ebarbershop_desktop/models/payment_detail/payment_detail.dart';
import 'package:ebarbershop_desktop/models/search_result.dart';
import 'package:ebarbershop_desktop/providers/narudzbe_detalji_provider.dart';
import 'package:ebarbershop_desktop/providers/payment_detail_provider.dart';
import 'package:ebarbershop_desktop/utils/util.dart';
import 'package:ebarbershop_desktop/widgets/master_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
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
  late PaymentDetailProvider _paymentDetailProvider;
  SearchResult<NarudzbeDetalji>? narudzbeDetaljiResult;
  PaymentDetail? paymentDetailResult;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    _narudzbeDetaljiProvider = context.read<NarudzbeDetaljiProvider>();
    _paymentDetailProvider = context.read<PaymentDetailProvider>();

    fetchNarudzbeDetalji();
  }

  Future fetchNarudzbeDetalji() async {
    try {
      narudzbeDetaljiResult = await _narudzbeDetaljiProvider
          .getNarudzbeDetalji(widget.narudzba.narudzbeId);

      paymentDetailResult = await _paymentDetailProvider
          .getByNarudzbaId(widget.narudzba.narudzbeId);

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
          build: (context) {
            return [
              pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                crossAxisAlignment: pw.CrossAxisAlignment.stretch,
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
                    'Broj narudzbe: ${widget.narudzba.brojNarudzbe}',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    textAlign: pw.TextAlign.center,
                  ),
                  pw.SizedBox(height: 20.0),
                  pw.Text('Informacije kupca',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.Divider(height: 20.0, color: PdfColor.fromHex("#9E9E9E")),
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
                  pw.Divider(height: 20.0, color: PdfColor.fromHex("#9E9E9E")),
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
                  if (paymentDetailResult != null) pw.SizedBox(height: 13.0),
                  if (paymentDetailResult != null)
                    pw.Container(
                      child: pw.Column(
                        children: [
                          pw.Row(
                            children: [
                              pw.Text('Transaction ID:'),
                              pw.SizedBox(width: 10.0),
                              pw.Text(paymentDetailResult!.transactionId)
                            ],
                          ),
                          pw.SizedBox(height: 5.0),
                          pw.Row(
                            children: [
                              pw.Text('Payment method:'),
                              pw.SizedBox(width: 10.0),
                              pw.Text(paymentDetailResult!.paymentMethod)
                            ],
                          ),
                          pw.SizedBox(height: 5.0),
                          pw.Row(
                            children: [
                              pw.Text('Total:'),
                              pw.SizedBox(width: 10.0),
                              pw.Text(paymentDetailResult!.total.toString())
                            ],
                          ),
                          pw.SizedBox(height: 5.0),
                          pw.Row(
                            children: [
                              pw.Text('Subtotal:'),
                              pw.SizedBox(width: 10.0),
                              pw.Text(paymentDetailResult!.subtotal.toString())
                            ],
                          ),
                          pw.SizedBox(height: 5.0),
                          pw.Row(
                            children: [
                              pw.Text('Shipping Discount:'),
                              pw.SizedBox(width: 10.0),
                              pw.Text(paymentDetailResult!.shippingDiscount
                                  .toString())
                            ],
                          ),
                          pw.SizedBox(height: 5.0),
                          pw.Row(
                            children: [
                              pw.Text('Currency:'),
                              pw.SizedBox(width: 10.0),
                              pw.Text(paymentDetailResult!.currency)
                            ],
                          ),
                          pw.SizedBox(height: 5.0),
                          pw.Row(
                            children: [
                              pw.Text('Status:'),
                              pw.SizedBox(width: 10.0),
                              pw.Text(paymentDetailResult!.message)
                            ],
                          ),
                        ],
                      ),
                    ),
                  if (paymentDetailResult != null) pw.SizedBox(height: 13.0),
                  if (paymentDetailResult != null)
                    pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        pw.Expanded(
                          flex: 1,
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            children: [
                              pw.Text('Payer Info:',
                                  style: const pw.TextStyle(
                                      decoration: pw.TextDecoration.underline)),
                              pw.SizedBox(height: 5.0),
                              pw.Row(
                                children: [
                                  pw.Text('Payer ID:'),
                                  pw.SizedBox(width: 10.0),
                                  pw.Text(paymentDetailResult!.payerId)
                                ],
                              ),
                              pw.SizedBox(height: 5.0),
                              pw.Row(
                                children: [
                                  pw.Text('First Name:'),
                                  pw.SizedBox(width: 10.0),
                                  pw.Text(paymentDetailResult!.payerFirstName)
                                ],
                              ),
                              pw.SizedBox(height: 5.0),
                              pw.Row(
                                children: [
                                  pw.Text('Last Name:'),
                                  pw.SizedBox(width: 10.0),
                                  pw.Text(paymentDetailResult!.payerLastName)
                                ],
                              ),
                            ],
                          ),
                        ),
                        pw.Expanded(
                          flex: 1,
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            children: [
                              pw.Text('Recipient Info:',
                                  style: const pw.TextStyle(
                                      decoration: pw.TextDecoration.underline)),
                              pw.SizedBox(height: 5.0),
                              pw.Row(
                                children: [
                                  pw.Text('Address:'),
                                  pw.SizedBox(width: 10.0),
                                  pw.Text(paymentDetailResult!.recipientAddress)
                                ],
                              ),
                              pw.SizedBox(height: 5.0),
                              pw.Row(
                                children: [
                                  pw.Text('City:'),
                                  pw.SizedBox(width: 10.0),
                                  pw.Text(paymentDetailResult!.recipientCity)
                                ],
                              ),
                              pw.SizedBox(height: 5.0),
                              pw.Row(
                                children: [
                                  pw.Text('State:'),
                                  pw.SizedBox(width: 10.0),
                                  pw.Text(paymentDetailResult!.recipientState)
                                ],
                              ),
                              pw.SizedBox(height: 5.0),
                              pw.Row(
                                children: [
                                  pw.Text('Postal Code:'),
                                  pw.SizedBox(width: 10.0),
                                  pw.Text(paymentDetailResult!
                                      .recipientPostalCode
                                      .toString())
                                ],
                              ),
                              pw.SizedBox(height: 5.0),
                              pw.Row(
                                children: [
                                  pw.Text('Country Code:'),
                                  pw.SizedBox(width: 10.0),
                                  pw.Text(
                                      paymentDetailResult!.recipientCountryCode)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  pw.SizedBox(height: 20.0),
                  pw.Text('Proizvodi',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.Divider(height: 20.0, color: PdfColor.fromHex("#9E9E9E")),
                  pw.Table(
                    children: [
                      pw.TableRow(
                        children: [
                          pw.Container(
                            padding: const pw.EdgeInsets.all(5.0),
                            child: pw.Text(
                              'Rb.',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
                            ),
                          ),
                          pw.Container(
                            padding: const pw.EdgeInsets.all(5.0),
                            child: pw.Text(
                              'Proizvod',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
                            ),
                          ),
                          pw.Container(
                            padding: const pw.EdgeInsets.all(5.0),
                            child: pw.Text(
                              'Sifra',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
                            ),
                          ),
                          pw.Container(
                            padding: const pw.EdgeInsets.all(5.0),
                            child: pw.Text(
                              'Kolicina',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
                            ),
                          ),
                          pw.Container(
                            padding: const pw.EdgeInsets.all(5.0),
                            child: pw.Text(
                              'Cijena',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      for (int i = 0;
                          i < narudzbeDetaljiResult!.result.length;
                          i++)
                        pw.TableRow(
                          children: [
                            pw.Container(
                              padding: const pw.EdgeInsets.all(5.0),
                              child: pw.Text('${i + 1}'),
                            ),
                            pw.Container(
                              padding: const pw.EdgeInsets.all(5.0),
                              child: pw.Text(narudzbeDetaljiResult!
                                      .result[i].nazivProizvoda ??
                                  ""),
                            ),
                            pw.Container(
                              padding: const pw.EdgeInsets.all(5.0),
                              child: pw.Text(narudzbeDetaljiResult!
                                      .result[i].sifraProizvoda ??
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
    final directory = await getDownloadsDirectory();
    final path =
        '${directory?.path}/${"${widget.narudzba.brojNarudzbe}_${DateTime.now().millisecondsSinceEpoch}.pdf"}';
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
            await generatePDF();
          },
          style: ElevatedButton.styleFrom(
            elevation: 0.0,
            foregroundColor: Colors.black,
            backgroundColor: Colors.red.shade200,
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
          width: double.infinity,
          padding: const EdgeInsets.all(25.0),
          margin: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
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
              if (paymentDetailResult != null) _buildTransactionDetailView(),
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

  Expanded _buildTransactionDetailView() {
    return Expanded(
      flex: 2,
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Transaction ID:',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.black54),
              ),
              const SizedBox(
                width: 20.0,
              ),
              Text(
                paymentDetailResult!.transactionId,
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
                'Payment method:',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.black54),
              ),
              const SizedBox(
                width: 20.0,
              ),
              Text(
                paymentDetailResult!.paymentMethod,
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
                'Total:',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.black54),
              ),
              const SizedBox(
                width: 20.0,
              ),
              Text(
                paymentDetailResult!.total.toString(),
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
                'Subtotal:',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.black54),
              ),
              const SizedBox(
                width: 20.0,
              ),
              Text(
                paymentDetailResult!.subtotal.toString(),
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
                'Shipping Discount:',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.black54),
              ),
              const SizedBox(
                width: 20.0,
              ),
              Text(
                paymentDetailResult!.shippingDiscount.toString(),
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
                'Currency:',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.black54),
              ),
              const SizedBox(
                width: 20.0,
              ),
              Text(
                paymentDetailResult!.currency.toString(),
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
                'Status:',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.black54),
              ),
              const SizedBox(
                width: 20.0,
              ),
              Text(
                paymentDetailResult!.message,
                style: const TextStyle(fontSize: 18.0),
              )
            ],
          ),
          const Divider(
            height: 40.0,
            thickness: 2.0,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Payer Info:',
                        style: TextStyle(
                            fontSize: 19.0,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                            decoration: TextDecoration.underline,
                            color: Colors.black54),
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Payer ID:',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.black54),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Text(
                          paymentDetailResult!.payerId,
                          style: const TextStyle(fontSize: 18.0),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: [
                        const Text(
                          'First name:',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.black54),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Text(
                          paymentDetailResult!.payerFirstName,
                          style: const TextStyle(fontSize: 18.0),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Last name:',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.black54),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Text(
                          paymentDetailResult!.payerLastName,
                          style: const TextStyle(fontSize: 18.0),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Recipient Info:',
                        style: TextStyle(
                            fontSize: 19.0,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                            decoration: TextDecoration.underline,
                            color: Colors.black54),
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Address:',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.black54),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Text(
                          paymentDetailResult!.recipientAddress,
                          style: const TextStyle(fontSize: 18.0),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: [
                        const Text(
                          'City:',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.black54),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Text(
                          paymentDetailResult!.recipientCity,
                          style: const TextStyle(fontSize: 18.0),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: [
                        const Text(
                          'State:',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.black54),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Text(
                          paymentDetailResult!.recipientState,
                          style: const TextStyle(fontSize: 18.0),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Postal Code:',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.black54),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Text(
                          paymentDetailResult!.recipientPostalCode.toString(),
                          style: const TextStyle(fontSize: 18.0),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Country Code:',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.black54),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Text(
                          paymentDetailResult!.recipientCountryCode,
                          style: const TextStyle(fontSize: 18.0),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
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
