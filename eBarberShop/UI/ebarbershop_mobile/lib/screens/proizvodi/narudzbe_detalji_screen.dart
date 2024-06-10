import 'package:ebarbershop_mobile/models/narudzbe/narudzbe.dart';
import 'package:ebarbershop_mobile/models/narudzbe/narudzbe_detalji.dart';
import 'package:ebarbershop_mobile/models/payment_detail/payment_detail.dart';
import 'package:ebarbershop_mobile/models/search_result.dart';
import 'package:ebarbershop_mobile/providers/narudzbe_detalji_provider.dart';
import 'package:ebarbershop_mobile/providers/payment_detail_provider.dart';
import 'package:ebarbershop_mobile/utils/util.dart';
import 'package:ebarbershop_mobile/widgets/master_screen_widget.dart';
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
  late PaymentDetailProvider _paymentDetailProvider;
  SearchResult<NarudzbeDetalji>? narudzbeDetaljiResult;
  PaymentDetail? paymentDetailResult;
  bool isLoading = true;
  late DateTime datumOtkazivanjaNarudzbe;

  static final TextStyle _customLabelStyle = TextStyle(
      fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.grey.shade900);

  static final TextStyle _customTextStyle = TextStyle(
      fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.grey.shade800);

  @override
  void initState() {
    super.initState();

    datumOtkazivanjaNarudzbe =
        widget.narudzba.datumNarudzbe.add(const Duration(days: 1));

    _narudzbeDetaljiProvider = context.read<NarudzbeDetaljiProvider>();
    _paymentDetailProvider = context.read<PaymentDetailProvider>();

    fetchData();
  }

  Future fetchData() async {
    narudzbeDetaljiResult = await _narudzbeDetaljiProvider
        .getNarudzbeDetalji(widget.narudzba.narudzbeId);

    paymentDetailResult = await _paymentDetailProvider
        .getByNarudzbaId(widget.narudzba.narudzbeId);

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: 'Detalji narudžbe',
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Datum narudžbe:',
                          style: _customLabelStyle,
                        ),
                      ),
                      Expanded(
                          flex: 3,
                          child: Text(
                            '${getDateFormat(widget.narudzba.datumNarudzbe)} | ${getTimeFormat(widget.narudzba.datumNarudzbe)}',
                            style: _customTextStyle,
                          ))
                    ],
                  ),
                  const Divider(
                    height: 30.0,
                  ),
                  Row(
                    children: [
                      Text(
                        'Status:',
                        style: _customLabelStyle,
                      ),
                      const SizedBox(width: 105.0),
                      if (widget.narudzba.otkazano != null &&
                          widget.narudzba.otkazano == false &&
                          datumOtkazivanjaNarudzbe.isAfter(DateTime.now()))
                        Container(
                          color: Colors.grey,
                          padding: const EdgeInsets.all(5.0),
                          child: const Text(
                            'In Progress',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      else if (widget.narudzba.otkazano != null &&
                          widget.narudzba.otkazano == true)
                        Container(
                          color: Colors.red,
                          padding: const EdgeInsets.all(5.0),
                          child: const Text(
                            'Cancelled',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      else if (widget.narudzba.otkazano != null &&
                          widget.narudzba.otkazano == false)
                        Container(
                          color: Colors.green,
                          padding: const EdgeInsets.all(5.0),
                          child: const Text(
                            'Completed',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      else
                        Container(
                          color: Colors.black54,
                          padding: const EdgeInsets.all(5.0),
                          child: const Text(
                            'Unknown',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  if (paymentDetailResult == null)
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Total:',
                                style: _customLabelStyle,
                              ),
                            ),
                            Expanded(
                                flex: 3,
                                child: Text(
                                  '${formatNumber(widget.narudzba.ukupanIznos)} KM',
                                  style: _customTextStyle,
                                ))
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Subtotal:',
                                style: _customLabelStyle,
                              ),
                            ),
                            Expanded(
                                flex: 3,
                                child: Text(
                                  '${formatNumber(widget.narudzba.ukupanIznos)} KM',
                                  style: _customTextStyle,
                                ))
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Shipping Discount:',
                                style: _customLabelStyle,
                              ),
                            ),
                            Expanded(
                                flex: 3,
                                child: Text(
                                  '0.0',
                                  style: _customTextStyle,
                                ))
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Total Items:',
                                style: _customLabelStyle,
                              ),
                            ),
                            Expanded(
                                flex: 3,
                                child: Text(
                                  narudzbeDetaljiResult!.result.length
                                      .toString(),
                                  style: _customTextStyle,
                                ))
                          ],
                        ),
                      ],
                    ),
                  if (paymentDetailResult != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Transaction ID:',
                                style: _customLabelStyle,
                              ),
                            ),
                            Expanded(
                                flex: 3,
                                child: Text(
                                  paymentDetailResult!.transactionId,
                                  style: _customTextStyle,
                                ))
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Payment method:',
                                style: _customLabelStyle,
                              ),
                            ),
                            Expanded(
                                flex: 3,
                                child: Text(
                                  paymentDetailResult!.paymentMethod,
                                  style: _customTextStyle,
                                ))
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Total:',
                                style: _customLabelStyle,
                              ),
                            ),
                            Expanded(
                                flex: 3,
                                child: Text(
                                  '${formatNumber(paymentDetailResult!.total)} KM',
                                  style: _customTextStyle,
                                ))
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Subtotal:',
                                style: _customLabelStyle,
                              ),
                            ),
                            Expanded(
                                flex: 3,
                                child: Text(
                                  '${formatNumber(paymentDetailResult!.subtotal)} KM',
                                  style: _customTextStyle,
                                ))
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Shipping Discount:',
                                style: _customLabelStyle,
                              ),
                            ),
                            Expanded(
                                flex: 3,
                                child: Text(
                                  paymentDetailResult!.shippingDiscount
                                      .toString(),
                                  style: _customTextStyle,
                                ))
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Total Items:',
                                style: _customLabelStyle,
                              ),
                            ),
                            Expanded(
                                flex: 3,
                                child: Text(
                                  narudzbeDetaljiResult!.result.length
                                      .toString(),
                                  style: _customTextStyle,
                                ))
                          ],
                        ),
                        const Divider(height: 30.0),
                        Container(
                          color: Colors.black12,
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Ship to',
                                  style: TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1.0)),
                              const Divider(height: 10.0),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      'Address:',
                                      style: _customLabelStyle,
                                    ),
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                        paymentDetailResult!.recipientAddress,
                                        style: _customTextStyle,
                                      ))
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      'City:',
                                      style: _customLabelStyle,
                                    ),
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                        paymentDetailResult!.recipientCity,
                                        style: _customTextStyle,
                                      ))
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      'State:',
                                      style: _customLabelStyle,
                                    ),
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                        paymentDetailResult!.recipientState,
                                        style: _customTextStyle,
                                      ))
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      'Postal Code:',
                                      style: _customLabelStyle,
                                    ),
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                        paymentDetailResult!.recipientPostalCode
                                            .toString(),
                                        style: _customTextStyle,
                                      ))
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      'Country Code:',
                                      style: _customLabelStyle,
                                    ),
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                        paymentDetailResult!
                                            .recipientCountryCode
                                            .toString(),
                                        style: _customTextStyle,
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  const Divider(height: 30.0),
                  const Text(
                    'Purchase details',
                    style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.0),
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    color: Colors.white54,
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Naziv proizvoda',
                            style: _customLabelStyle,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Količina',
                            style: _customLabelStyle,
                          ),
                        ),
                        Expanded(
                          flex: 0,
                          child: Text(
                            'Cijena',
                            style: _customLabelStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: narudzbeDetaljiResult!.result.length,
                    itemBuilder: (BuildContext context, int index) {
                      var narudzbaDetalj = narudzbeDetaljiResult!.result[index];
                      return Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  narudzbaDetalj.nazivProizvoda ?? "",
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey.shade800),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  narudzbaDetalj.kolicina.toString(),
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey.shade800),
                                ),
                              ),
                              Expanded(
                                flex: 0,
                                child: Text(
                                  '${formatNumber(narudzbaDetalj.cijenaProizvoda)} KM',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey.shade800),
                                ),
                              ),
                            ],
                          ));
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        height: 15.0,
                        thickness: 1.0,
                        color: Colors.grey.shade400,
                      );
                    },
                  )
                ],
              ),
            ),
    );
  }
}
