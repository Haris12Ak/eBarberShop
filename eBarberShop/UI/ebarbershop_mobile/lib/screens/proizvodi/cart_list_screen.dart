import 'dart:convert';
import 'dart:developer';

import 'package:ebarbershop_mobile/models/cart/cart.dart';
import 'package:ebarbershop_mobile/models/narudzbe/narudzbe.dart';
import 'package:ebarbershop_mobile/models/narudzbe/narudzbe_detalji_insert_request.dart';
import 'package:ebarbershop_mobile/models/narudzbe/narudzbe_insert_request.dart';
import 'package:ebarbershop_mobile/models/payment_detail/payment_detail.dart';
import 'package:ebarbershop_mobile/models/payment_detail/payment_detail_insert_request.dart';
import 'package:ebarbershop_mobile/providers/cart_provider.dart';
import 'package:ebarbershop_mobile/providers/narudzbe_detalji_provider.dart';
import 'package:ebarbershop_mobile/providers/narudzbe_provider.dart';
import 'package:ebarbershop_mobile/providers/payment_detail_provider.dart';
import 'package:ebarbershop_mobile/screens/paypal/paypal_checkout_view.dart';
import 'package:ebarbershop_mobile/utils/util.dart';
import 'package:ebarbershop_mobile/widgets/master_screen_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

class CartListScreen extends StatefulWidget {
  const CartListScreen({super.key});

  @override
  State<CartListScreen> createState() => _CartListScreenState();
}

class _CartListScreenState extends State<CartListScreen> {
  late CartProvider _cartProvider;
  late NarudzbeProvider _narudzbeProvider;
  late NarudzbeDetaljiProvider _narudzbeDetaljiProvider;
  late PaymentDetailProvider _paymentDetailProvider;

  String? transactionID;
  String? paymentMethod;
  String? payerId;
  String? payerFirstName;
  String? payerLastName;
  String? recipientName;
  String? recipientAddress;
  String? recipientCity;
  String? recipientState;
  String? recipientPostalCode;
  String? recipientCountryCode;
  String? total;
  String? currency;
  String? subtotal;
  String? shippingDiscount;
  String? message;
  String? createTime;

  static final TextStyle _customStyle = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: Colors.grey[900],
    fontFamily: 'Dosis',
    letterSpacing: 1,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _cartProvider = context.watch<CartProvider>();
    _narudzbeProvider = context.read<NarudzbeProvider>();
    _narudzbeDetaljiProvider = context.read<NarudzbeDetaljiProvider>();
    _paymentDetailProvider = context.read<PaymentDetailProvider>();
  }

  PaymentDetail saveTransactionDetails(params) {
    transactionID = params['data']['transactions'][0]['related_resources'][0]
            ['sale']['id'] ??
        "";

    paymentMethod = params['data']['payer']['payment_method'] ?? "";

    payerId = params['data']['payer']['payer_info']['payer_id'] ?? "";

    payerFirstName = params['data']['payer']['payer_info']['first_name'] ?? "";

    payerLastName = params['data']['payer']['payer_info']['last_name'] ?? "";

    recipientName = params['data']['payer']['payer_info']['shipping_address']
            ['recipient_name'] ??
        "";

    recipientAddress = params['data']['payer']['payer_info']['shipping_address']
            ['line1'] ??
        "";

    recipientCity =
        params['data']['payer']['payer_info']['shipping_address']['city'] ?? "";

    recipientState = params['data']['payer']['payer_info']['shipping_address']
            ['state'] ??
        "";

    recipientPostalCode = params['data']['payer']['payer_info']
            ['shipping_address']['postal_code'] ??
        "0";

    recipientCountryCode = params['data']['payer']['payer_info']
            ['shipping_address']['country_code'] ??
        "";

    total = params['data']['transactions'][0]['amount']['total'] ?? "0.0";

    currency = params['data']['transactions'][0]['amount']['currency'] ?? "";

    subtotal = params['data']['transactions'][0]['amount']['details']
            ['subtotal'] ??
        "0.0";

    shippingDiscount = params['data']['transactions'][0]['amount']['details']
            ['shipping_discount'] ??
        "0.0";

    message = params['message'] ?? "";

    createTime = params['data']['create_time'] ?? "";

    PaymentDetail paymentDetail = PaymentDetail(
        transactionID!,
        paymentMethod!,
        payerId!,
        payerFirstName!,
        payerLastName!,
        recipientName!,
        recipientAddress!,
        recipientCity!,
        recipientState!,
        int.parse(recipientPostalCode!),
        recipientCountryCode!,
        double.parse(total!),
        currency!,
        double.parse(subtotal!),
        double.parse(shippingDiscount!),
        message!,
        DateTime.parse(createTime!));

    return paymentDetail;
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: 'Košarica',
      child: _cartProvider.cart.items.isEmpty
          ? const Center(
              child: Image(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/empty-cart.png')),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: _cartProvider.cart.items.length,
                      itemBuilder: _buildCartList),
                ),
                const Divider(),
                Container(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Ukupno artikla:', style: _customStyle),
                          Text(
                            ' ${_cartProvider.cart.items.length}',
                            style: _customStyle,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Ukupan iznos:', style: _customStyle),
                          Text(
                            ' ${formatNumber(_cartProvider.totalPrice)} BAM',
                            style: _customStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => PaypalCheckoutView(
                        sandboxMode: true,
                        clientId: dotenv.env['CLIENT_ID'],
                        secretKey: dotenv.env['SECRET_KEY'],
                        transactions: [
                          {
                            "amount": {
                              "total":
                                  _cartProvider.totalPrice.toStringAsFixed(2),
                              "currency": "USD",
                              "details": {
                                "subtotal":
                                    _cartProvider.totalPrice.toStringAsFixed(2),
                                "shipping": '0',
                                "shipping_discount": 0
                              }
                            },
                            "description":
                                "The payment transaction description.",
                            /* "payment_options": const {
                              "allowed_payment_method": "INSTANT_FUNDING_SOURCE"
                            }, */
                            "item_list": {
                              "items": _cartProvider.cart.items.map((item) {
                                return {
                                  "name": item.proizvod.naziv,
                                  "quantity": item.count,
                                  "price":
                                      item.proizvod.cijena.toStringAsFixed(2),
                                  "currency": "USD",
                                };
                              }).toList(),
                              "shipping_address": const {
                                "recipient_name": "Barber Shop",
                                "line1": "13th Street",
                                "line2": "",
                                "city": "Brooklyn",
                                "country_code": "US",
                                "postal_code": "11215",
                                "phone": "+4087128852",
                                "state": "NY"
                              },
                            }
                          }
                        ],
                        note: "Contact us for any questions on your order.",
                        onSuccess: (Map params) async {
                          log("onSuccess: $params");

                          var transactionDetailInfo =
                              saveTransactionDetails(params);

                          try {
                            double ukupanIznos = _cartProvider.totalPrice;

                            NarudzbeInsertRequest request =
                                NarudzbeInsertRequest(
                                    DateTime.now(),
                                    ukupanIznos,
                                    true,
                                    false,
                                    Authorization.korisnikId!);

                            Narudzbe orderData =
                                await _narudzbeProvider.insert(request);

                            for (var item in _cartProvider.cart.items) {
                              NarudzbeDetaljiInsertRequest
                                  narudzbeDetaljiRequest =
                                  NarudzbeDetaljiInsertRequest(
                                      item.count,
                                      orderData.narudzbeId,
                                      item.proizvod.proizvodiId);

                              await _narudzbeDetaljiProvider
                                  .insert(narudzbeDetaljiRequest);
                            }

                            PaymentDetailInsertRequest paymentDetailRequest =
                                PaymentDetailInsertRequest(
                                    transactionDetailInfo.transactionId,
                                    transactionDetailInfo.paymentMethod,
                                    transactionDetailInfo.payerId,
                                    transactionDetailInfo.payerFirstName,
                                    transactionDetailInfo.payerLastName,
                                    transactionDetailInfo.recipientName,
                                    transactionDetailInfo.recipientAddress,
                                    transactionDetailInfo.recipientCity,
                                    transactionDetailInfo.recipientState,
                                    transactionDetailInfo.recipientPostalCode,
                                    transactionDetailInfo.recipientCountryCode,
                                    transactionDetailInfo.total,
                                    transactionDetailInfo.currency,
                                    transactionDetailInfo.subtotal,
                                    transactionDetailInfo.shippingDiscount,
                                    transactionDetailInfo.message,
                                    transactionDetailInfo.createTime,
                                    orderData.narudzbeId);

                            await _paymentDetailProvider
                                .insert(paymentDetailRequest);

                            _cartProvider.totalPrice = 0.0;
                            _cartProvider.cart.items.clear();

                            // ignore: use_build_context_synchronously
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      icon: const Icon(
                                        Icons.check_circle_outline_outlined,
                                        color: Colors.green,
                                        size: 40.0,
                                      ),
                                      title: const Text('Success!'),
                                      content: const Text(
                                          'Successful transaction!.'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            while (Navigator.canPop(context)) {
                                              Navigator.pop(context);
                                            }
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ));
                          } on Exception catch (e) {
                            // ignore: use_build_context_synchronously
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text("Error"),
                                content: Text(e.toString()),
                                actions: [
                                  TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("OK"))
                                ],
                              ),
                            );
                          }
                        },
                        onError: (error) {
                          log("onError: $error");
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    icon: const Icon(
                                      Icons.sms_failed_outlined,
                                      color: Colors.red,
                                      size: 30.0,
                                    ),
                                    title: const Text('Faild!'),
                                    content: const Text('Transaction failed!.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          while (Navigator.canPop(context)) {
                                            Navigator.pop(context);
                                          }
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ));
                        },
                        onCancel: () {
                          if (kDebugMode) {
                            print('cancelled:');
                          }
                          Navigator.pop(context);
                        },
                      ),
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    padding: const EdgeInsets.all(8.0),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue.shade600,
                    side: BorderSide(color: Colors.grey.withOpacity(.2)),
                    shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.zero),
                  ),
                  icon: const Image(
                    fit: BoxFit.contain,
                    image: AssetImage('assets/images/paypal_icon.png'),
                    width: 25,
                    height: 25,
                  ),
                  label: const Text(
                    'Pay with paypal',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
    );
  }

  Widget? _buildCartList(BuildContext context, int index) {
    CartItem item = _cartProvider.cart.items[index];
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.only(bottom: 10.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 3.0, color: Colors.black12),
        ),
      ),
      child: ListTile(
        title:
            Text(item.proizvod.naziv, style: const TextStyle(fontSize: 17.0)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              item.proizvod.vrstaProizvodaNaziv ?? "",
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(
              height: 8.0,
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: 'Cijena: ',
                      style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w500)),
                  TextSpan(
                      text: '${formatNumber(item.proizvod.cijena)} KM',
                      style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w400)),
                ],
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: 'Količina: ',
                      style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w500)),
                  TextSpan(
                      text: item.count.toString(),
                      style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w400)),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            Align(
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20.0)),
                margin: const EdgeInsets.only(left: 50.0, right: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                        onTap: () {
                          if (item.count > 1) {
                            _cartProvider
                                .removeTotalPrice(item.proizvod.cijena);
                            setState(() {
                              item.count -= 1;
                            });
                          }
                        },
                        child: const Icon(Icons.remove)),
                    const Text(
                      '|',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                        onTap: () {
                          _cartProvider.addTotalPrice(item.proizvod.cijena);
                          setState(() {
                            item.count += 1;
                          });
                        },
                        child: const Icon(Icons.add)),
                  ],
                ),
              ),
            ),
          ],
        ),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: item.proizvod.slika != "" && item.proizvod.slika != null
              ? Image(
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  image: MemoryImage(
                    base64Decode(
                      item.proizvod.slika.toString(),
                    ),
                  ),
                )
              : const Image(
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/image_not_available.png'),
                ),
        ),
        trailing: GestureDetector(
          onTap: () {
            _cartProvider.removeFromCart(item.proizvod);

            for (int i = 0; i < item.count; i++) {
              _cartProvider.removeTotalPrice(item.proizvod.cijena);
            }
          },
          child: const Icon(Icons.delete_forever),
        ),
      ),
    );
  }
}
