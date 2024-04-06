import 'package:ebarbershop_desktop/models/rezervacije/rezervacija.dart';
import 'package:ebarbershop_desktop/models/search_result.dart';
import 'package:ebarbershop_desktop/providers/rezervacija_provider.dart';
import 'package:ebarbershop_desktop/screens/rezervacije/rezervacije_termin_add_screen.dart';
import 'package:ebarbershop_desktop/utils/util.dart';
import 'package:ebarbershop_desktop/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RezervacijeTerminiScreen extends StatefulWidget {
  const RezervacijeTerminiScreen({super.key});

  @override
  State<RezervacijeTerminiScreen> createState() =>
      _RezervacijeTerminiScreenState();
}

class _RezervacijeTerminiScreenState extends State<RezervacijeTerminiScreen> {
  late RezervacijaProvider _rezervacijaProvider;
  SearchResult<Rezervacija>? terminiResult;
  DateTime? _selectedDate;
  final TextEditingController _imePrezimeController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    _rezervacijaProvider = context.read<RezervacijaProvider>();

    fetchTermine();
  }

  Future fetchTermine() async {
    terminiResult =
        await _rezervacijaProvider.get(filter: {'IsUposlenikIncluded': true});

    setState(() {
      isLoading = false;
    });
  }

  bool isAktivna(String datum) {
    var dateTime = DateTime.parse(datum);
    return dateTime.isBefore(DateTime.now());
  }

  Future<void> filter() async {
    var data = await _rezervacijaProvider.get(filter: {
      'datum': _selectedDate,
      'imePrezimeUposlenika': _imePrezimeController.text,
      'IsUposlenikIncluded': true
    });

    setState(() {
      terminiResult = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: 'Termini',
      selectedOption: 'Termini',
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
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const RezervacijeTerminAddScreen()))
                            .then((_) => {fetchTermine()});
                      },
                      icon: const Icon(Icons.access_time),
                      label: const Text(
                        'Označi termin zauzetim',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 3,
                        child: TextField(
                          controller: _imePrezimeController,
                          decoration: const InputDecoration(
                              labelText: "Ime i prezime",
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
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
                            contentPadding:
                                const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
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
                                _formKey.currentState!.fields['date']
                                    ?.didChange(null);

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
                            shape: const BeveledRectangleBorder(
                                borderRadius: BorderRadius.zero),
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
                              _imePrezimeController.text = "";
                              _selectedDate = null;
                            });
                            _formKey.currentState!.fields['date']
                                ?.didChange(null);

                            await filter();
                          },
                          icon: const Icon(Icons.refresh),
                          label: const Text(
                            'Reset',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          style: ElevatedButton.styleFrom(
                            elevation: 8.0,
                            shape: const BeveledRectangleBorder(
                                borderRadius: BorderRadius.zero),
                            backgroundColor: Colors.blueGrey[300],
                            foregroundColor: Colors.white,
                            minimumSize: const Size(100, 50),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Expanded(
                    child: SingleChildScrollView(
                      child: DataTable(
                          dataTextStyle: const TextStyle(fontSize: 16.0),
                          decoration:
                              const BoxDecoration(color: Colors.white70),
                          columns: const <DataColumn>[
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  'Uposlenik',
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
                                  'Datum',
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
                                  'Vrijeme',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black54),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Status',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black54),
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
                          rows: terminiResult?.result
                                  .map((Rezervacija e) =>
                                      DataRow(cells: <DataCell>[
                                        DataCell(Text(
                                            '${e.uposlenikIme} ${e.uposlenikPrezime}')),
                                        DataCell(Text(getDateFormat(e.datum))),
                                        DataCell(
                                            Text(getTimeFormat(e.vrijeme))),
                                        DataCell(Container(
                                          child: isAktivna(e.vrijeme.toString())
                                              ? Text(
                                                  'Neaktivno',
                                                  style: TextStyle(
                                                      color: Colors.red[900],
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )
                                              : Text(
                                                  'Aktivno',
                                                  style: TextStyle(
                                                      color: Colors.blue[900],
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                        )),
                                        DataCell(
                                          IconButton(
                                            tooltip: 'Obriši',
                                            onPressed: () {
                                              try {
                                                // ignore: use_build_context_synchronously
                                                showDialog(
                                                  barrierDismissible: false,
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          AlertDialog(
                                                    title:
                                                        const Text('Potvrda'),
                                                    content: Text(
                                                        'Jeste li sigurni da želite ukloniti termin datuma: ${getDateFormat(e.datum)} ${getTimeFormat(e.vrijeme)} !'),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () async {
                                                          await _rezervacijaProvider
                                                              .delete(e
                                                                  .rezervacijaId);

                                                          // ignore: use_build_context_synchronously
                                                          Navigator.of(context)
                                                              .pop();

                                                          fetchTermine();
                                                        },
                                                        child: const Text('Da'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: const Text('Ne'),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              } on Exception catch (e) {
                                                // ignore: use_build_context_synchronously
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
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        child: const Text("OK"),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }
                                            },
                                            icon: const Icon(
                                                Icons.delete_forever),
                                          ),
                                        )
                                      ]))
                                  .toList() ??
                              []),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                    child: Text(
                      'Ukupno podataka: ${terminiResult?.count}',
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
}
