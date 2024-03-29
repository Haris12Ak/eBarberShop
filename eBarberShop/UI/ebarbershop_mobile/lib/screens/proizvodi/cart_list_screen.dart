import 'dart:convert';

import 'package:ebarbershop_mobile/models/cart/cart.dart';
import 'package:ebarbershop_mobile/models/narudzbe/narudzbe.dart';
import 'package:ebarbershop_mobile/models/narudzbe/narudzbe_detalji_insert_request.dart';
import 'package:ebarbershop_mobile/models/narudzbe/narudzbe_insert_request.dart';
import 'package:ebarbershop_mobile/providers/cart_provider.dart';
import 'package:ebarbershop_mobile/providers/narudzbe_detalji_provider.dart';
import 'package:ebarbershop_mobile/providers/narudzbe_provider.dart';
import 'package:ebarbershop_mobile/utils/util.dart';
import 'package:ebarbershop_mobile/widgets/master_screen_widget.dart';
import 'package:flutter/material.dart';
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
                Container(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Ukupno proizvoda:', style: _customStyle),
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
                            ' ${formatNumber(_cartProvider.totalPrice)} KM',
                            style: _customStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                ElevatedButton.icon(
                    onPressed: () async {
                      try {
                        double ukupanIznos = _cartProvider.totalPrice;

                        NarudzbeInsertRequest request = NarudzbeInsertRequest(
                            DateTime.now(),
                            ukupanIznos,
                            true,
                            false,
                            Authorization.korisnikId!);

                        Narudzbe orderData =
                            await _narudzbeProvider.insert(request);

                        for (var item in _cartProvider.cart.items) {
                          NarudzbeDetaljiInsertRequest narudzbeDetaljiRequest =
                              NarudzbeDetaljiInsertRequest(
                                  item.count,
                                  orderData.narudzbeId,
                                  item.proizvod.proizvodiId);

                          await _narudzbeDetaljiProvider
                              .insert(narudzbeDetaljiRequest);
                        }

                        _cartProvider.totalPrice = 0.0;
                        _cartProvider.cart.items.clear();

                        // ignore: use_build_context_synchronously
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text("Poruka"),
                            content: const Text("Narudzba Uspješno dodana"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  child: const Text("OK"))
                            ],
                          ),
                        );
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
                    style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white),
                    icon: const Icon(Icons.shop),
                    label: const Text(
                      'Naruči',
                      style: TextStyle(fontSize: 16),
                    ))
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
        title: Text(item.proizvod.naziv),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('${formatNumber(item.proizvod.cijena)} KM'),
            Text(item.count.toString()),
            const SizedBox(height: 8.0),
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
