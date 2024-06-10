import 'dart:convert';

import 'package:ebarbershop_mobile/models/proizvodi/proizvodi.dart';
import 'package:ebarbershop_mobile/models/proizvodi/vrste_proizvoda.dart';
import 'package:ebarbershop_mobile/models/search_result.dart';
import 'package:ebarbershop_mobile/providers/cart_provider.dart';
import 'package:ebarbershop_mobile/providers/proizvodi_provider.dart';
import 'package:ebarbershop_mobile/providers/vrste_proizvoda_provider.dart';
import 'package:ebarbershop_mobile/screens/proizvodi/cart_list_screen.dart';
import 'package:ebarbershop_mobile/screens/proizvodi/pregled_narudzbi_screen.dart';
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
  late VrsteProizvodaProvider _vrsteProizvodaProvider;

  SearchResult<Proizvodi>? proizvodiReslut;
  SearchResult<VrsteProizvoda>? vrsteProizvodiReslut;
  bool isLoading = true;
  bool isFilterDataLoading = false;

  String? selectedValue;
  String? selectedProductName;

  final TextEditingController _nazivProizvodaController =
      TextEditingController();

  String selectedOption = 'Kosarica';

  @override
  void initState() {
    super.initState();

    _proizvodiProvider = context.read<ProizvodiProvider>();
    _cartProvider = context.read<CartProvider>();
    _vrsteProizvodaProvider = context.read<VrsteProizvodaProvider>();

    fetchProizvode();
  }

  Future fetchProizvode() async {
    proizvodiReslut = await _proizvodiProvider.get(
        filter: {'IsVrsteProizvodaIncluded': true, 'IsAktivanProizvod': true});

    proizvodiReslut!.result
        .sort((a, b) => b.proizvodiId.compareTo(a.proizvodiId));

    vrsteProizvodiReslut = await _vrsteProizvodaProvider.get();

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> filter() async {
    setState(() {
      isFilterDataLoading = true;
    });

    var data = await _proizvodiProvider.get(filter: {
      "naziv": _nazivProizvodaController.text,
      "vrstaProizvoda": selectedProductName,
      'IsAktivanProizvod': true,
      'IsVrsteProizvodaIncluded': true
    });

    setState(() {
      proizvodiReslut = data;
      isFilterDataLoading = false;
    });
  }

  void navigateToSelectedOption(String option) {
    switch (option) {
      case 'Kosarica':
        Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const CartListScreen()))
            .then((value) => setState(() {
                  _cartProvider.getCounter();
                }));
        break;
      case 'Narudzbe':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    const PregledNarudzbiScreen()));
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Proizvodi',
                    style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Dosis',
                        color: Colors.grey[900]),
                  ),
                  Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black38,
                          spreadRadius: 0,
                          blurRadius: 3,
                          offset: Offset(1, 2),
                        ),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                          child: DropdownButton<String>(
                              value: selectedOption,
                              hint: const Text('Opcije'),
                              dropdownColor: Colors.lightBlue[50],
                              iconSize: 30.0,
                              style: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                              ),
                              icon: const Icon(Icons.arrow_drop_down_outlined),
                              underline: Container(
                                height: 2,
                                color: Colors.grey.shade700,
                              ),
                              items: [
                                DropdownMenuItem<String>(
                                  value: 'Kosarica',
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Icon(Icons.shopping_cart,
                                          size: 22.0,
                                          color: Colors.grey.shade800),
                                      const SizedBox(width: 8.0),
                                      Text(
                                          'Košarica (${_cartProvider.getCounter()})'),
                                    ],
                                  ),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Narudzbe',
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Icon(Icons.receipt,
                                          size: 22.0,
                                          color: Colors.grey.shade800),
                                      const SizedBox(width: 8.0),
                                      const Text('Pregled narudžbi'),
                                    ],
                                  ),
                                ),
                              ],
                              onChanged: (String? value) {
                                setState(() {
                                  selectedOption = value!;
                                });

                                navigateToSelectedOption(selectedOption);
                              }),
                        ),
                        Positioned(
                          left: 0.0,
                          top: 0.0,
                          child: Text(
                            'Opcije',
                            style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1.0,
                                color: Colors.grey.shade800),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextField(
                controller: _nazivProizvodaController,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.only(left: 10.0, right: 10.0),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  focusedBorder: const OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white30,
                  hintText: 'Naziv proizvoda',
                  suffixIcon: IconButton(
                      onPressed: () async {
                        setState(() {
                          _nazivProizvodaController.text = "";
                        });
                        await filter();
                      },
                      icon: const Icon(
                        Icons.clear,
                        size: 26,
                      )),
                ),
                onChanged: (value) {
                  setState(() {
                    _nazivProizvodaController.text = value;
                  });
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black54,
                          ),
                          color: Colors.white30,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: DropdownButton(
                        value: selectedValue,
                        items: [
                          const DropdownMenuItem(
                            value: null,
                            child: Text('Vrste proizvoda (All)'),
                          ),
                          ...vrsteProizvodiReslut?.result
                                  .map(
                                    (item) => DropdownMenuItem(
                                      value: item.vrsteProizvodaId.toString(),
                                      child: Text(item.naziv),
                                    ),
                                  )
                                  .toList() ??
                              [],
                        ],
                        onChanged: (item) async {
                          setState(() {
                            selectedValue = item as String?;
                          });

                          if (item == null) {
                            setState(() {
                              selectedProductName = "";
                            });

                            await filter();
                          } else {
                            final selectedProduct = vrsteProizvodiReslut?.result
                                .firstWhere((product) =>
                                    product.vrsteProizvodaId.toString() ==
                                    item);

                            setState(() {
                              selectedProductName = selectedProduct?.naziv;
                            });

                            await filter();
                          }
                        },
                        isExpanded: true,
                        iconSize: 28,
                        style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                        hint: const Text('Vrste proizvoda'),
                        icon: const Icon(Icons.filter_list),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  ElevatedButton.icon(
                      onPressed: () async {
                        await filter();
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.grey.shade700,
                        side: BorderSide(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      icon: const Icon(
                        Icons.search,
                        size: 25,
                      ),
                      label: const Text(
                        'Pretraga',
                        style: TextStyle(fontSize: 15),
                      ))
                ],
              ),
              const SizedBox(height: 10.0),
              isFilterDataLoading
                  ? Container(
                      padding: const EdgeInsets.only(top: 120),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : proizvodiReslut!.result.isEmpty
                      ? Container(
                          padding: const EdgeInsets.only(top: 120),
                          child: const Center(
                            child: Text(
                              'Nema rezultata pretrage !',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        )
                      : Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1,
                              mainAxisExtent: 235,
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
