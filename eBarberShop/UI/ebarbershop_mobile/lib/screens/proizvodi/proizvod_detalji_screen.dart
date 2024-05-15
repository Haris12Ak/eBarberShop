import 'dart:convert';

import 'package:ebarbershop_mobile/models/proizvodi/proizvodi.dart';
import 'package:ebarbershop_mobile/providers/cart_provider.dart';
import 'package:ebarbershop_mobile/providers/recommend_provider.dart';
import 'package:ebarbershop_mobile/screens/proizvodi/cart_list_screen.dart';
import 'package:ebarbershop_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ProizvodDetaljiScreen extends StatefulWidget {
  Proizvodi proizvod;
  ProizvodDetaljiScreen({super.key, required this.proizvod});

  @override
  State<ProizvodDetaljiScreen> createState() => _ProizvodDetaljiScreenState();
}

class _ProizvodDetaljiScreenState extends State<ProizvodDetaljiScreen> {
  late CartProvider _cartProvider;
  late RecommendProvider _recommendProvider;

  List<Proizvodi> recommendedProizvodi = [];

  bool isLoading = true;

  static final TextStyle _customStyle = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
    color: Colors.grey[700],
    fontFamily: 'Dosis',
    letterSpacing: 1,
  );

  static final TextStyle _customHeaderStyle = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w600,
    color: Colors.grey[900],
    fontFamily: 'Dosis',
    letterSpacing: 1,
  );

  @override
  void initState() {
    super.initState();

    _cartProvider = context.read<CartProvider>();
    _recommendProvider = context.read<RecommendProvider>();

    fetchRecommendProizvodi();
  }

  Future fetchRecommendProizvodi() async {
    recommendedProizvodi = await _recommendProvider
        .recommendProizvodi(widget.proizvod.proizvodiId);

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[50],
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () {
              while (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
            icon: const Icon(
              Icons.close_sharp,
              size: 28.0,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: widget.proizvod.slika != "" &&
                              widget.proizvod.slika != null
                          ? Image(
                              width: 150,
                              height: 150,
                              fit: BoxFit.contain,
                              image: MemoryImage(
                                base64Decode(
                                  widget.proizvod.slika.toString(),
                                ),
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey.shade200),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: const Image(
                                width: 150,
                                height: 150,
                                fit: BoxFit.contain,
                                image: AssetImage(
                                    'assets/images/image_not_available.png'),
                              ),
                            ),
                    ),
                    const SizedBox(width: 20.0),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            widget.proizvod.naziv,
                            style: _customHeaderStyle,
                            overflow: TextOverflow.clip,
                            softWrap: true,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            widget.proizvod.vrstaProizvodaNaziv ?? "",
                            style: _customStyle,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '${formatNumber(widget.proizvod.cijena)} KM',
                            style: _customStyle,
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  elevation: 0.0,
                                  backgroundColor: Colors.white),
                              onPressed: () {
                                try {
                                  _cartProvider.addToCart(widget.proizvod);
                                  _cartProvider
                                      .addTotalPrice(widget.proizvod.cijena);

                                  setState(() {
                                    _cartProvider.getCounter();
                                  });

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      showCloseIcon: false,
                                      backgroundColor: Colors.blue[800],
                                      duration: Durations.extralong4,
                                      content: const Text(
                                          "Proizvod dodan u košaricu."),
                                    ),
                                  );
                                } catch (e) {
                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.red[800],
                                      showCloseIcon: false,
                                      duration: Durations.extralong4,
                                      content: const Text(
                                          "Proizvod je več dodan u košaricu."),
                                    ),
                                  );
                                }
                              },
                              icon: Icon(
                                Icons.add_shopping_cart,
                                color: Colors.grey[900],
                              ),
                              label: Text(
                                'Dodaj u košaricu',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.w600),
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'Opis proizvoda',
                style: _customHeaderStyle,
              ),
              const SizedBox(height: 5),
              Text(
                widget.proizvod.opis ?? "Nema opisa . . .",
                style: _customStyle,
              ),
              const SizedBox(height: 15.0),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const CartListScreen()))
                      .then((value) => setState(() {
                            _cartProvider.getCounter();
                          }));
                },
                style: ElevatedButton.styleFrom(
                  elevation: 5.0,
                  backgroundColor: Colors.lightBlue,
                  foregroundColor: Colors.white,
                  shape: const BeveledRectangleBorder(
                      borderRadius: BorderRadius.zero),
                ),
                icon: const Icon(Icons.shopping_cart_outlined),
                label: Text(
                  'Prikaži artikle (${_cartProvider.getCounter().toString()})',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              Divider(
                  color: Colors.grey.shade400, thickness: 2.0, height: 30.0),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(10.0)),
                padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Kupci koji su kupili ovaj proizvod su također kupili',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade700),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : recommendedProizvodi.isEmpty
                            ? Text(
                                widget.proizvod.opis ??
                                    "Nema rezultata pretrage !",
                                textAlign: TextAlign.center,
                                style: _customStyle,
                              )
                            : SizedBox(
                                height: 235,
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    childAspectRatio: 4 / 3,
                                  ),
                                  itemCount: recommendedProizvodi.length,
                                  itemBuilder: _buildListRecommendedProizvodi,
                                ),
                              ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget? _buildListRecommendedProizvodi(BuildContext context, int index) {
    Proizvodi proizvod = recommendedProizvodi[index];
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
              proizvod.vrstaProizvodaNaziv ?? "",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700]),
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
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}
