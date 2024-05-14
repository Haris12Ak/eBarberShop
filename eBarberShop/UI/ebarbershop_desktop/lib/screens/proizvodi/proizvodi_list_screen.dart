import 'package:ebarbershop_desktop/models/proizvodi/proizvodi.dart';
import 'package:ebarbershop_desktop/models/search_result.dart';
import 'package:ebarbershop_desktop/models/vrsteProizvoda/vrste_proizvoda.dart';
import 'package:ebarbershop_desktop/providers/proizvodi_provider.dart';
import 'package:ebarbershop_desktop/providers/vrste_proizvoda_provider.dart';
import 'package:ebarbershop_desktop/screens/proizvodi/proizvodi_edit_screen.dart';
import 'package:ebarbershop_desktop/utils/util.dart';
import 'package:ebarbershop_desktop/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProizvodiListScreen extends StatefulWidget {
  const ProizvodiListScreen({super.key});

  @override
  State<ProizvodiListScreen> createState() => _ProizvodiListScreenState();
}

class _ProizvodiListScreenState extends State<ProizvodiListScreen> {
  late ProizvodiProvider _proizvodiProvider;
  late VrsteProizvodaProvider _vrsteProizvodaProvider;

  late SearchResult<Proizvodi>? proizvodiSearchResult;
  late SearchResult<VrsteProizvoda>? vrsteProizvodiReslut;

  bool isLoading = true;
  final TextEditingController _nazivSearchController = TextEditingController();
  final TextEditingController _sifraSearchController = TextEditingController();

  String? selectedValue;
  String? selectedProductName;

  @override
  void initState() {
    super.initState();

    _proizvodiProvider = context.read<ProizvodiProvider>();
    _vrsteProizvodaProvider = context.read<VrsteProizvodaProvider>();

    fetchProizvodi();
  }

  Future fetchProizvodi() async {
    proizvodiSearchResult = await _proizvodiProvider
        .get(filter: {'IsVrsteProizvodaIncluded': true});

    vrsteProizvodiReslut = await _vrsteProizvodaProvider.get();

    setState(() {
      isLoading = false;
    });
  }

  Future<void> filter() async {
    var data = await _proizvodiProvider.get(filter: {
      'naziv': _nazivSearchController.text,
      'sifra': _sifraSearchController.text,
      "vrstaProizvoda": selectedProductName,
      'IsVrsteProizvodaIncluded': true
    });

    setState(() {
      proizvodiSearchResult = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: 'Proizvodi',
      selectedOption: 'Proizvodi',
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context)
                          .push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              ProizvodiEditScreen(),
                        ),
                      )
                          .then((_) {
                        fetchProizvodi();
                      });
                    },
                    icon: const Icon(Icons.add),
                    label: const Text(
                      'Dodaj proizvod',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 8.0,
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      minimumSize: const Size(100, 50),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                _buildSearch(),
                const SizedBox(
                  height: 20.0,
                ),
                _buildProizvodiList(),
                Container(
                  padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                  child: Text(
                    'Ukupno podataka: ${proizvodiSearchResult?.count}',
                    style: const TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.0,
                        fontSize: 15.0),
                  ),
                )
              ],
            ),
    );
  }

  Expanded _buildProizvodiList() {
    return Expanded(
      child: SingleChildScrollView(
        child: DataTable(
            dataTextStyle: const TextStyle(fontSize: 16.0),
            decoration: const BoxDecoration(color: Colors.white70),
            columns: const <DataColumn>[
              DataColumn(
                label: Expanded(
                  child: Text(
                    'ID',
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
                    'Naziv',
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
                    'Vrsta proizvoda',
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
                    'Šifra',
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
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Slika',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.black54),
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'Akcije',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.black54),
                ),
              ),
            ],
            rows: proizvodiSearchResult?.result
                    .map((Proizvodi e) => DataRow(cells: <DataCell>[
                          DataCell(Text(e.proizvodiId.toString())),
                          DataCell(Text(e.naziv)),
                          DataCell(Text(e.vrstaProizvodaNaziv ?? "")),
                          DataCell(Text(e.sifra)),
                          DataCell(Text('${formatNumber(e.cijena)} KM')),
                          DataCell(e.slika != ""
                              ? SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: imageFromBase64String(e.slika!),
                                )
                              : const Text('')),
                          DataCell(
                            Row(
                              children: [
                                IconButton(
                                    tooltip: 'Detalji/Uredi',
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ProizvodiEditScreen(
                                            proizvod: e,
                                          ),
                                        ),
                                      )
                                          .then((_) {
                                        fetchProizvodi();
                                      });
                                    },
                                    icon: const Icon(Icons.edit)),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                IconButton(
                                  tooltip: 'Obriši',
                                  onPressed: () {
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: const Text('Potvrda'),
                                        content: Text(
                                            'Jeste li sigurni da želite ukloniti proizvod: ${e.naziv} !'),
                                        actions: [
                                          TextButton(
                                            onPressed: () async {
                                              try {
                                                await _proizvodiProvider
                                                    .delete(e.proizvodiId)
                                                    .then((value) =>
                                                        Navigator.of(context)
                                                            .pop());

                                                if (!context.mounted) {
                                                  return;
                                                }

                                                fetchProizvodi();
                                              } on Exception catch (e) {
                                                Navigator.of(context).pop();

                                                showDialog(
                                                  barrierDismissible: false,
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          AlertDialog(
                                                    title: const Text("Error"),
                                                    content: Text(e.toString()),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child:
                                                            const Text("Close"),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }
                                            },
                                            child: const Text('Da'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Ne'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.delete_forever),
                                ),
                              ],
                            ),
                          )
                        ]))
                    .toList() ??
                []),
      ),
    );
  }

  Row _buildSearch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          flex: 3,
          child: TextField(
            controller: _nazivSearchController,
            decoration: const InputDecoration(
                labelText: "Naziv",
                contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                border: OutlineInputBorder()),
          ),
        ),
        const SizedBox(width: 30.0),
        Expanded(
          flex: 3,
          child: TextField(
            controller: _sifraSearchController,
            decoration: const InputDecoration(
                labelText: "Šifra",
                contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                border: OutlineInputBorder()),
          ),
        ),
        const SizedBox(width: 30.0),
        Expanded(
          flex: 2,
          child: Container(
            decoration:
                BoxDecoration(border: Border.all(color: Colors.black54)),
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
                      .firstWhere((proizvod) =>
                          proizvod.vrsteProizvodaId.toString() == item);

                  setState(() {
                    selectedProductName = selectedProduct?.naziv;
                  });

                  await filter();
                }
              },
              isExpanded: true,
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              dropdownColor: Colors.grey.shade300,
              focusColor: Colors.grey.shade300,
              iconSize: 28,
              elevation: 0,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              hint: const Text('Vrste proizvoda'),
              icon: const Icon(Icons.filter_list),
            ),
          ),
        ),
        const SizedBox(
          width: 50.0,
        ),
        Expanded(
          flex: 1,
          child: ElevatedButton.icon(
            onPressed: () async {
              await filter();
            },
            icon: const Icon(Icons.search),
            label: const Text(
              'Pretraga',
              style: TextStyle(fontSize: 16.0),
            ),
            style: ElevatedButton.styleFrom(
              elevation: 8.0,
              shape:
                  const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
              backgroundColor: Colors.blueGrey,
              foregroundColor: Colors.white,
              minimumSize: const Size(100, 50),
            ),
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        Expanded(
          flex: 1,
          child: ElevatedButton.icon(
            onPressed: () async {
              setState(() {
                _nazivSearchController.text = "";
                _sifraSearchController.text = "";
                selectedProductName = "";
                selectedValue = null;
              });

              await filter();
            },
            icon: const Icon(Icons.refresh),
            label: const Text(
              'Reset',
              style: TextStyle(fontSize: 16.0),
            ),
            style: ElevatedButton.styleFrom(
              elevation: 8.0,
              shape:
                  const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
              backgroundColor: Colors.blueGrey[300],
              foregroundColor: Colors.white,
              minimumSize: const Size(100, 50),
            ),
          ),
        ),
      ],
    );
  }
}
