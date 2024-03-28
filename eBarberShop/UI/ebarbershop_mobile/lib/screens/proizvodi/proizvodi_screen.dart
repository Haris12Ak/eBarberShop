import 'dart:convert';

import 'package:ebarbershop_mobile/models/proizvodi/proizvodi.dart';
import 'package:ebarbershop_mobile/models/search_result.dart';
import 'package:ebarbershop_mobile/providers/cart_provider.dart';
import 'package:ebarbershop_mobile/providers/proizvodi_provider.dart';
import 'package:ebarbershop_mobile/screens/proizvodi/cart_list_screen.dart';
import 'package:ebarbershop_mobile/screens/proizvodi/proizvod_detalji_screen.dart';
import 'package:ebarbershop_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProizvodiScreen extends StatefulWidget {
  const ProizvodiScreen({super.key});

  @override
  State<ProizvodiScreen> createState() => _ProizvodiScreenState();
}

class _ProizvodiScreenState extends State<ProizvodiScreen> {
  late ProizvodiProvider _proizvodiProvider;
  late CartProvider _cartProvider;

  SearchResult<Proizvodi>? proizvodiReslut;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    _proizvodiProvider = context.read<ProizvodiProvider>();
    _cartProvider = context.read<CartProvider>();

    fetchProizvode();
  }

  Future fetchProizvode() async {
    proizvodiReslut = await _proizvodiProvider.get();

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dobrodošli u našu online trgovinu !',
                      style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Dosis',
                          color: Colors.grey[800]),
                    ),
                    const SizedBox(
                      height: 2.0,
                    ),
                    Text(
                      'Ovdje možete pregledati naš asortiman proizvoda za njegu brade, kose i opreme za stiliziranje. U nastavku su navedeni proizvodi koje imamo na raspolaganju.',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                        fontFamily: 'Dosis',
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                        //margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            color: Colors.white60,
                            borderRadius: BorderRadius.circular(50.0)),
                        width: 50,
                        height: 50,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const CartListScreen()))
                                .then((value) => setState(() {
                                      _cartProvider.getCounter();
                                    }));
                          },
                          child: const Icon(
                            Icons.shopping_cart_outlined,
                            size: 28,
                            color: Colors.black,
                          ),
                        )),
                    Positioned(
                      right: 0.0,
                      top: 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: Text(
                          _cartProvider.getCounter().toString(),
                          style: const TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.red),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    mainAxisExtent: 260,
                  ),
                  itemCount: proizvodiReslut!.result.length,
                  itemBuilder: _buildListaProizvoda,
                ),
              ),
            ],
          );
  }

  Widget? _buildListaProizvoda(BuildContext context, int index) {
    Proizvodi proizvod = proizvodiReslut!.result[index];
    return GestureDetector(
      onTap: () {
        Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        ProizvodDetaljiScreen(proizvod: proizvod)))
            .then((value) => setState(() {
                  _cartProvider.getCounter();
                }));
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
                color: Colors.blueGrey,
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(3, 4)),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: proizvod.slika != "" && proizvod.slika != null
                  ? Image(
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      image: MemoryImage(
                        base64Decode(
                          proizvod.slika.toString(),
                        ),
                      ),
                    )
                  : const Image(
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      image:
                          AssetImage('assets/images/image_not_available.png'),
                    ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              proizvod.naziv,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800]),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              '${formatNumber(proizvod.cijena)} KM',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700]),
            ),
            const SizedBox(
              height: 8.0,
            ),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    elevation: 1.0, backgroundColor: Colors.blue[50]),
                onPressed: () {
                  try {
                    _cartProvider.addToCart(proizvod);
                    _cartProvider.addTotalPrice(proizvod.cijena);

                    setState(() {
                      _cartProvider.getCounter();
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        showCloseIcon: false,
                        backgroundColor: Colors.blue[800],
                        duration: Durations.long1,
                        content: const Text("Proizvod dodan u košaricu."),
                      ),
                    );
                  } catch (e) {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red[800],
                        showCloseIcon: false,
                        duration: Durations.long1,
                        content:
                            const Text("Proizvod je več dodan u košaricu."),
                      ),
                    );
                  }
                },
                icon: Icon(
                  Icons.add_shopping_cart,
                  color: Colors.grey[900],
                ),
                label: Text(
                  'Dodaj',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w600),
                ))
          ],
        ),
      ),
    );
  }
}
