import 'package:ebarbershop_desktop/models/rezervacije/rezervacija.dart';
import 'package:ebarbershop_desktop/models/search_result.dart';
import 'package:ebarbershop_desktop/models/usluga/usluga.dart';
import 'package:ebarbershop_desktop/providers/rezervacija_provider.dart';
import 'package:ebarbershop_desktop/providers/usluga_provider.dart';
import 'package:ebarbershop_desktop/screens/rezervacije/rezervacije_izvjestaj_screen.dart';
import 'package:ebarbershop_desktop/utils/util.dart';
import 'package:ebarbershop_desktop/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RezervacijeScreen extends StatefulWidget {
  const RezervacijeScreen({super.key});

  @override
  State<RezervacijeScreen> createState() => _RezervacijeScreenState();
}

class _RezervacijeScreenState extends State<RezervacijeScreen> {
  late RezervacijaProvider _rezervacijaProvider;
  late UslugaProvider _uslugaProvider;
  SearchResult<Rezervacija>? rezervacijeResult;
  SearchResult<Usluga>? uslugeResult;

  bool isLoading = true;

  final _formKey = GlobalKey<FormBuilderState>();

  final TextEditingController _imePrezimeKlijenta = TextEditingController();
  DateTime? _selectedDate;
  DateTime? datumIzvjestaj;

  String? selectedValue;
  String? selectedNazivUsluge;

  @override
  void initState() {
    super.initState();

    _rezervacijaProvider = context.read<RezervacijaProvider>();
    _uslugaProvider = context.read<UslugaProvider>();

    fetchRezervacije();
    fetchUsluge();
  }

  Future fetchRezervacije() async {
    rezervacijeResult = await _rezervacijaProvider
        .get(filter: {'IsKorisnikIncluded': true, 'IsUslugaIncluded': true});

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future fetchUsluge() async {
    uslugeResult = await _uslugaProvider.get();

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  bool isAktivna(String datum) {
    var dateTime = DateTime.parse(datum);
    return dateTime.isBefore(DateTime.now());
  }

  Future<void> filter() async {
    var data = await _rezervacijaProvider.get(filter: {
      'Datum': _selectedDate,
      'ImePrezimeKorisnika': _imePrezimeKlijenta.text,
      'NazivUsluge': selectedNazivUsluge,
      'IsKorisnikIncluded': true,
      'IsUslugaIncluded': true
    });

    setState(() {
      rezervacijeResult = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: 'Rezervacije',
      selectedOption: 'Rezervacije',
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : FormBuilder(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildIzvjestaj(context),
                  const SizedBox(height: 25.0),
                  _buildSearch(),
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
                                  'Klijent',
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
                                  'Usluga',
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
                              label: Expanded(
                                child: Text(
                                  'Status',
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
                          rows: rezervacijeResult?.result
                                  .map((Rezervacija e) =>
                                      DataRow(cells: <DataCell>[
                                        DataCell(Text(
                                            '${e.klijentIme} ${e.klijentPrezime}')),
                                        DataCell(Text(e.nazivUsluge ?? "")),
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
                                                        'Jeste li sigurni da želite ukloniti rezervaciju kreiranu datuma: ${getDateFormat(e.datum)} !'),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () async {
                                                          Navigator.of(context)
                                                              .pop();

                                                          await _rezervacijaProvider
                                                              .delete(e
                                                                  .rezervacijaId);

                                                          fetchRezervacije();
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
                      'Ukupno podataka: ${rezervacijeResult?.count}',
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

  Stack _buildIzvjestaj(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(25.0),
          margin: const EdgeInsets.only(top: 15.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black38, width: 2.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Kreiraj izvještaj za odabrani datum do danas (opcionalno)',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.black54),
              ),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: 500,
                child: FormBuilderDateTimePicker(
                  name: 'datumIzvjestaj',
                  initialValue: datumIzvjestaj,
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
                      onPressed: () {
                        _formKey.currentState!.fields['datumIzvjestaj']
                            ?.didChange(null);
                      },
                      icon: const Icon(Icons.clear),
                    ),
                  ),
                  inputType: InputType.date,
                  format: DateFormat("yyyy-MM-dd"),
                  onChanged: (DateTime? newDate) {
                    setState(() {
                      datumIzvjestaj = newDate;
                    });
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () async {
                    if (datumIzvjestaj == null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  RezervacijeIzvjestajScreen(
                                    datum: datumIzvjestaj,
                                  ))).then((value) => _formKey
                          .currentState!.fields['datumIzvjestaj']
                          ?.didChange(null));
                    } else if (datumIzvjestaj!.isAfter(DateTime.now())) {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(
                                  'Greška prilikom kreiranja izvještaja!'),
                              content: const Text(
                                  'Odabrani datum mora biti manji od trenutnog datuma, tj. današnjeg datuma! \nMolimo unesite ispravan datum.'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('OK')),
                              ],
                            );
                          });
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  RezervacijeIzvjestajScreen(
                                    datum: datumIzvjestaj,
                                  ))).then((value) => _formKey
                          .currentState!.fields['datumIzvjestaj']
                          ?.didChange(null));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.grey.shade500,
                    padding: const EdgeInsets.all(18.0),
                    shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.zero),
                  ),
                  child: const Text(
                    'Izvještaj',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: -2.0,
          left: 15.0,
          child: Container(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            color: Colors.grey.shade100,
            child: const Text(
              'Izvještaj',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.black54),
            ),
          ),
        ),
      ],
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
            controller: _imePrezimeKlijenta,
            decoration: const InputDecoration(
                labelText: "Ime i prezime klijenta",
                contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                border: OutlineInputBorder()),
          ),
        ),
        const SizedBox(width: 30.0),
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
                    icon: const Icon(Icons.clear))),
            inputType: InputType.date,
            format: DateFormat("yyyy-MM-dd"),
            onChanged: (DateTime? newDate) async {
              setState(
                () {
                  _selectedDate = newDate;
                },
              );
              await filter();
            },
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
                  child: Text('Usluge (All)'),
                ),
                ...uslugeResult?.result
                        .map(
                          (item) => DropdownMenuItem(
                            value: item.uslugaId.toString(),
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
                    selectedNazivUsluge = "";
                  });

                  await filter();
                } else {
                  final selectedUsluga = uslugeResult?.result.firstWhere(
                      (usluga) => usluga.uslugaId.toString() == item);

                  setState(() {
                    selectedNazivUsluge = selectedUsluga?.naziv;
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
              setState(() {
                _imePrezimeKlijenta.text = "";
                selectedNazivUsluge = "";
                selectedValue = null;
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
}
