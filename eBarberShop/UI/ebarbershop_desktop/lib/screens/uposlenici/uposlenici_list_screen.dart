import 'package:ebarbershop_desktop/models/search_result.dart';
import 'package:ebarbershop_desktop/models/uposlenik/uposlenik.dart';
import 'package:ebarbershop_desktop/providers/uposlenik_provider.dart';
import 'package:ebarbershop_desktop/screens/uposlenici/uposlenik_edit_screen.dart';
import 'package:ebarbershop_desktop/utils/util.dart';
import 'package:ebarbershop_desktop/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UposleniciListScreen extends StatefulWidget {
  const UposleniciListScreen({super.key});

  @override
  State<UposleniciListScreen> createState() => _UposleniciListScreenState();
}

class _UposleniciListScreenState extends State<UposleniciListScreen> {
  late UposlenikProvider _uposlenikProvider;
  late SearchResult<Uposlenik>? uposlenikSearchResult;
  bool isLoading = true;

  final TextEditingController _imeSearchController = TextEditingController();
  final TextEditingController _prezimeSearchController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    _uposlenikProvider = context.read<UposlenikProvider>();

    fetchUposlenici();
  }

  Future fetchUposlenici() async {
    var data = await _uposlenikProvider.get();

    setState(() {
      uposlenikSearchResult = data;
      isLoading = false;
    });
  }

  Future<void> filter() async {
    var data = await _uposlenikProvider.get(filter: {
      'ime': _imeSearchController.text,
      'prezime': _prezimeSearchController.text
    });

    setState(() {
      uposlenikSearchResult = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: 'Uposlenici',
      selectedOption: 'Uposlenici',
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
                              UposlenikEditScreen(),
                        ),
                      )
                          .then((_) {
                        fetchUposlenici();
                      });
                    },
                    icon: const Icon(Icons.add),
                    label: const Text(
                      'Dodaj uposlenika',
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
                _buildUposleniciList(),
                Container(
                  padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                  child: Text(
                    'Ukupno podataka: ${uposlenikSearchResult?.count}',
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

  Expanded _buildUposleniciList() {
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
                    'Ime',
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
                    'Prezime',
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
                    'Kontakt telefon',
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
                    'Email',
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
                    'Adresa',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.black54),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        'Ocjena',
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.black54),
                      ),
                    ],
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
            rows: uposlenikSearchResult?.result
                    .map((Uposlenik e) => DataRow(cells: <DataCell>[
                          DataCell(Text(e.uposlenikId.toString())),
                          DataCell(Text(e.ime)),
                          DataCell(Text(e.prezime)),
                          DataCell(Text(e.kontaktTelefon)),
                          DataCell(Text(e.email ?? "")),
                          DataCell(Text(e.adresa ?? "")),
                          DataCell(Text(formatNumber(e.prosjecnaOcjena))),
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
                                              UposlenikEditScreen(
                                            uposlenik: e,
                                          ),
                                        ),
                                      )
                                          .then((_) {
                                        fetchUposlenici();
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
                                              'Jeste li sigurni da želite ukloniti uposlenika: ${e.ime} ${e.prezime} !'),
                                          actions: [
                                            TextButton(
                                              onPressed: () async {
                                                try {
                                                  Navigator.of(context).pop();

                                                  await _uposlenikProvider
                                                      .delete(e.uposlenikId);

                                                  fetchUposlenici();
                                                } on Exception catch (e) {
                                                  // ignore: use_build_context_synchronously
                                                  showDialog(
                                                    barrierDismissible: false,
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        AlertDialog(
                                                      title:
                                                          const Text("Error"),
                                                      content:
                                                          Text(e.toString()),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child:
                                                              const Text("OK"),
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
                                    icon: const Icon(Icons.delete_forever))
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          flex: 3,
          child: TextField(
            controller: _imeSearchController,
            decoration: const InputDecoration(
                labelText: "Ime",
                contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                border: OutlineInputBorder()),
          ),
        ),
        const SizedBox(width: 30.0),
        Expanded(
          flex: 3,
          child: TextField(
            controller: _prezimeSearchController,
            decoration: const InputDecoration(
                labelText: "Prezime",
                contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                border: OutlineInputBorder()),
          ),
        ),
        const SizedBox(width: 50.0),
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
              _imeSearchController.text = "";
              _prezimeSearchController.text = "";

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
