import 'package:ebarbershop_desktop/models/search_result.dart';
import 'package:ebarbershop_desktop/models/uposlenik/uposlenik.dart';
import 'package:ebarbershop_desktop/providers/uposlenik_provider.dart';
import 'package:ebarbershop_desktop/screens/uposlenici/uposlenik_edit_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: 'Uposlenici',
      selectedOption: 'Uposlenici',
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
                _buildSearch(),
                const SizedBox(
                  height: 40.0,
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
                    'Uposlenik ID',
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
                          DataCell(Text(e.email.toString())),
                          DataCell(Text(e.adresa.toString())),
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
                                      try {
                                        // ignore: use_build_context_synchronously
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            title: const Text('Potvrda'),
                                            content: Text(
                                                'Jeste li sigurni da želite ukloniti uposlenika: ${e.ime} ${e.prezime} !'),
                                            actions: [
                                              TextButton(
                                                onPressed: () async {
                                                  await _uposlenikProvider
                                                      .delete(e.uposlenikId);

                                                  Navigator.of(context).pop();

                                                  fetchUposlenici();
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
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          width: 500,
          child: TextField(
            controller: _imeSearchController,
            decoration: const InputDecoration(
              labelText: "Ime",
            ),
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        SizedBox(
          width: 500,
          child: TextField(
            controller: _prezimeSearchController,
            decoration: const InputDecoration(labelText: "Prezime"),
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        ElevatedButton.icon(
          onPressed: () async {
            var data = await _uposlenikProvider.get(filter: {
              'ime': _imeSearchController.text,
              'prezime': _prezimeSearchController.text
            });

            setState(() {
              uposlenikSearchResult = data;
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
            _imeSearchController.text = "";
            _prezimeSearchController.text = "";

            var data = await _uposlenikProvider.get();

            setState(() {
              uposlenikSearchResult = data;
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
