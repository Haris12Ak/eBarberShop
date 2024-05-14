import 'package:ebarbershop_desktop/models/novosti/novosti.dart';
import 'package:ebarbershop_desktop/models/search_result.dart';
import 'package:ebarbershop_desktop/providers/novosti_provider.dart';
import 'package:ebarbershop_desktop/screens/novosti/novosti_edit_screen.dart';
import 'package:ebarbershop_desktop/utils/util.dart';
import 'package:ebarbershop_desktop/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NovostiListScreen extends StatefulWidget {
  const NovostiListScreen({super.key});

  @override
  State<NovostiListScreen> createState() => _NovostiListScreenState();
}

class _NovostiListScreenState extends State<NovostiListScreen> {
  late NovostiProvider _novostiProvider;
  late SearchResult<Novosti>? novostiSearchResult;
  bool isLoading = true;
  final _formKey = GlobalKey<FormBuilderState>();

  final TextEditingController _naslovSearchController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();

    _novostiProvider = context.read<NovostiProvider>();

    fetctNovosti();
  }

  Future fetctNovosti() async {
    novostiSearchResult =
        await _novostiProvider.get(filter: {'IsKorisnikInclude': true});

    setState(() {
      isLoading = false;
    });
  }

  Future<void> filter() async {
    var data = await _novostiProvider.get(filter: {
      'naslov': _naslovSearchController.text,
      'datumObjave': _selectedDate,
      'IsKorisnikInclude': true
    });

    setState(() {
      novostiSearchResult = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: 'Novosti',
      selectedOption: 'Novosti',
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : FormBuilder(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context)
                            .push(
                          MaterialPageRoute(
                            builder: (context) => NovostiEditScreen(),
                          ),
                        )
                            .then((_) {
                          fetctNovosti();
                        });
                      },
                      icon: const Icon(Icons.add),
                      label: const Text(
                        'Dodaj novost',
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
                  const SizedBox(height: 25.0),
                  _buildSearch(),
                  const SizedBox(height: 20.0),
                  _buildNovostiList(),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                    child: Text(
                      'Ukupno podataka: ${novostiSearchResult?.count}',
                      style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.0,
                          fontSize: 15.0),
                    ),
                  )
                ],
              ),
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
            controller: _naslovSearchController,
            decoration: const InputDecoration(
                labelText: "Naslov",
                contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                border: OutlineInputBorder()),
          ),
        ),
        const SizedBox(
          width: 30.0,
        ),
        Expanded(
          flex: 2,
          child: FormBuilderDateTimePicker(
            name: 'date',
            initialValue: _selectedDate,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
              prefixIcon: const Icon(Icons.date_range),
              labelText: 'Odaberite datum',
              floatingLabelStyle: const TextStyle(
                color: Colors.black54,
                fontSize: 17.0,
                fontWeight: FontWeight.w600,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
              suffixIcon: IconButton(
                onPressed: () async {
                  _formKey.currentState!.fields['date']?.didChange(null);

                  await filter();
                },
                icon: const Icon(Icons.clear),
              ),
            ),
            inputType: InputType.date,
            format: DateFormat("yyyy-MM-dd"),
            onChanged: (DateTime? newDate) async {
              setState(() {
                _selectedDate = newDate;
              });
              await filter();
            },
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
                _naslovSearchController.text = "";
                _selectedDate = null;
              });

              _formKey.currentState!.fields['date']?.didChange(null);

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

  Expanded _buildNovostiList() {
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
                    'Naslov',
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
                    'Datum objave',
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
                    'Objavio korisnik',
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
            rows: novostiSearchResult?.result
                    .map((Novosti e) => DataRow(cells: <DataCell>[
                          DataCell(Text(e.novostiId.toString())),
                          DataCell(Text(e.naslov)),
                          DataCell(Text(formatDate(e.datumObjave))),
                          DataCell(Text(e.korisnikImePrezime ?? "")),
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
                                              NovostiEditScreen(
                                            novost: e,
                                          ),
                                        ),
                                      )
                                          .then((_) {
                                        fetctNovosti();
                                      });
                                    },
                                    icon: const Icon(Icons.edit)),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                _buildDeleteNovost(e)
                              ],
                            ),
                          )
                        ]))
                    .toList() ??
                []),
      ),
    );
  }

  IconButton _buildDeleteNovost(Novosti e) {
    return IconButton(
        tooltip: 'Obriši',
        onPressed: () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Potvrda'),
              content: Text(
                  'Jeste li sigurni da želite ukloniti novost objavljena datuma: ${formatDate(e.datumObjave)} !'),
              actions: [
                TextButton(
                  onPressed: () async {
                    try {
                      await _novostiProvider
                          .delete(e.novostiId)
                          .then((value) => Navigator.of(context).pop());

                      if (!context.mounted) {
                        return;
                      }

                      fetctNovosti();
                    } on Exception catch (e) {
                      Navigator.of(context).pop();

                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text("Error"),
                          content: Text(e.toString()),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("Close"),
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
        icon: const Icon(Icons.delete_forever));
  }
}
