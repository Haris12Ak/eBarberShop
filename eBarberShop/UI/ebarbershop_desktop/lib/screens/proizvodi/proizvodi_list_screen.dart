import 'package:ebarbershop_desktop/models/proizvodi/proizvodi.dart';
import 'package:ebarbershop_desktop/models/search_result.dart';
import 'package:ebarbershop_desktop/providers/proizvodi_provider.dart';
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
  late SearchResult<Proizvodi>? proizvodiSearchResult;

  bool isLoading = true;
  TextEditingController _nazivSearchController = TextEditingController();
  TextEditingController _sifraSearchController = TextEditingController();
  @override
  void initState() {
    super.initState();

    _proizvodiProvider = context.read<ProizvodiProvider>();

    fetchProizvodi();
  }

  Future fetchProizvodi() async {
    proizvodiSearchResult = await _proizvodiProvider.get();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: 'Proizvodi',
      selectedOption: 'Proizvodi',
      child: isLoading
          ? Container()
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
                _buildSearch(),
                const SizedBox(
                  height: 40.0,
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
                    'Proizvod ID',
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
                          DataCell(Text(e.cijena.toStringAsFixed(2))),
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
                                    try {
                                      // ignore: use_build_context_synchronously
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: const Text('Potvrda'),
                                          content: Text(
                                              'Jeste li sigurni da želite ukloniti proizvod: ${e.naziv} !'),
                                          actions: [
                                            TextButton(
                                              onPressed: () async {
                                                await _proizvodiProvider
                                                    .delete(e.proizvodiId);

                                                Navigator.of(context).pop();

                                                fetchProizvodi();
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
                                    } on Exception catch (e) {
                                      // ignore: use_build_context_synchronously
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: const Text("Error"),
                                          content: Text(e.toString()),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: const Text("OK"),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
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
      children: [
        SizedBox(
          width: 500,
          child: TextField(
            controller: _nazivSearchController,
            decoration: const InputDecoration(
              labelText: "Naziv",
            ),
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        SizedBox(
          width: 500,
          child: TextField(
            controller: _sifraSearchController,
            decoration: const InputDecoration(labelText: "Šifra"),
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        ElevatedButton.icon(
          onPressed: () async {
            var data = await _proizvodiProvider.get(filter: {
              'naziv': _nazivSearchController.text,
              'sifra': _sifraSearchController.text
            });

            setState(() {
              proizvodiSearchResult = data;
            });
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
        const SizedBox(
          width: 20.0,
        ),
        ElevatedButton.icon(
          onPressed: () async {
            _nazivSearchController.text = "";
            _sifraSearchController.text = "";

            var data = await _proizvodiProvider.get();

            setState(() {
              proizvodiSearchResult = data;
            });
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
      ],
    );
  }
}
