import 'package:ebarbershop_desktop/models/search_result.dart';
import 'package:ebarbershop_desktop/models/termini/termini_uposlenika.dart';
import 'package:ebarbershop_desktop/providers/rezervacija_provider.dart';
import 'package:ebarbershop_desktop/screens/rezervacije/prikazi_termine_uposlenika.dart';
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
  SearchResult<TerminiUposlenika>? terminiUposlenikaResult;

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
    try {
      terminiUposlenikaResult =
          await _rezervacijaProvider.getTermineUposlenika();

      terminiUposlenikaResult!.result
          .sort((a, b) => b.datum.compareTo(a.datum));

      setState(() {
        isLoading = false;
      });
    } on Exception catch (e) {
      // ignore: use_build_context_synchronously
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
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  bool isAktivna(String datum) {
    var inputDate = DateTime.parse(datum);
    var today = DateTime.now();

    var inputDateOnly =
        DateTime(inputDate.year, inputDate.month, inputDate.day);
    var todayOnly = DateTime(today.year, today.month, today.day);

    return inputDateOnly.isBefore(todayOnly);
  }

  Future<void> filter() async {
    var data = await _rezervacijaProvider.getTermineUposlenika(filter: {
      'Datum': _selectedDate,
      'ImePrezimeUposlenika': _imePrezimeController.text,
    });

    data.result.sort((a, b) => b.datum.compareTo(a.datum));

    setState(() {
      terminiUposlenikaResult = data;
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
                          dividerThickness: 2.0,
                          dataRowMaxHeight: 55,
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
                                  'Ukupno termina',
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
                                '',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black54),
                              ),
                            ),
                          ],
                          rows: terminiUposlenikaResult?.result
                                  .map((TerminiUposlenika e) =>
                                      DataRow(cells: <DataCell>[
                                        DataCell(Text(
                                            '${e.imeUposlenika} ${e.prezimeUposlenika}')),
                                        DataCell(Text(getDateFormat(e.datum))),
                                        DataCell(
                                            Text(e.brojTermina.toString())),
                                        DataCell(Container(
                                          child: isAktivna(e.datum.toString())
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
                                            tooltip: 'Prikaži termine',
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          PrikaziTermineUposlenika(
                                                            imePrezimeUposlenika:
                                                                '${e.imeUposlenika} ${e.prezimeUposlenika}',
                                                            datum: e.datum,
                                                          ))).then(
                                                  (value) => fetchTermine());
                                            },
                                            icon: const Icon(Icons.access_time),
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
                      'Ukupno podataka: ${terminiUposlenikaResult?.count}',
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
