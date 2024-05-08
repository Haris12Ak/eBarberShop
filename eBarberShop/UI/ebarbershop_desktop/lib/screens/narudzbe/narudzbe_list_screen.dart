import 'package:ebarbershop_desktop/models/narudzbe/narudzbe.dart';
import 'package:ebarbershop_desktop/models/search_result.dart';
import 'package:ebarbershop_desktop/providers/narudzbe_provider.dart';
import 'package:ebarbershop_desktop/screens/narudzbe/narudzbe_detalji_screen.dart';
import 'package:ebarbershop_desktop/screens/narudzbe/narudzbe_izvjestaj_screen.dart';
import 'package:ebarbershop_desktop/utils/util.dart';
import 'package:ebarbershop_desktop/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NarudzbeListScreen extends StatefulWidget {
  const NarudzbeListScreen({super.key});

  @override
  State<NarudzbeListScreen> createState() => _NarudzbeListScreenState();
}

class _NarudzbeListScreenState extends State<NarudzbeListScreen> {
  late NarudzbeProvider _narudzbeProvider;
  SearchResult<Narudzbe>? narudzbeResult;

  bool isLoading = true;

  final _formKey = GlobalKey<FormBuilderState>();

  DateTime? _selectedDate;
  final TextEditingController _brojNarudzbeController = TextEditingController();

  DateTime? _datumOd;
  DateTime? _datumDo;

  @override
  void initState() {
    super.initState();

    _narudzbeProvider = context.read<NarudzbeProvider>();

    fetchNarudzbe();
  }

  Future fetchNarudzbe() async {
    narudzbeResult =
        await _narudzbeProvider.get(filter: {'isKorisnikIncluded': true});

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> filter() async {
    var data = await _narudzbeProvider.get(filter: {
      'datumNarudzbe': _selectedDate,
      'brojNarudzbe': _brojNarudzbeController.text,
      'isKorisnikIncluded': true
    });

    setState(() {
      narudzbeResult = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: 'Narudžbe',
      selectedOption: 'Narudzbe',
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
                                  'Kupac',
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
                                  'Broj narudžbe',
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
                                  'Datum/Vrijeme',
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
                                  'Ukupan iznos',
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
                          rows: narudzbeResult?.result
                                  .map((Narudzbe e) =>
                                      DataRow(cells: <DataCell>[
                                        DataCell(Text(
                                            '${e.imeKorisnika ?? ""} ${e.prezimeKorisnika ?? ""}')),
                                        DataCell(Text(e.brojNarudzbe)),
                                        DataCell(Text(
                                            '${getDateFormat(e.datumNarudzbe)}  |  ${getTimeFormat(e.datumNarudzbe)}')),
                                        DataCell(Text(
                                            '${formatNumber(e.ukupanIznos)} KM')),
                                        DataCell(
                                          Row(
                                            children: [
                                              _buildPrikaziDetaljeNarudzbe(
                                                  context, e),
                                              const SizedBox(
                                                width: 10.0,
                                              ),
                                              _buildUkloniNarudzbu(context, e)
                                            ],
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
                      'Ukupno podataka: ${narudzbeResult?.count}',
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

  IconButton _buildUkloniNarudzbu(BuildContext context, Narudzbe e) {
    return IconButton(
        tooltip: 'Obriši',
        onPressed: () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Potvrda'),
              content: Text(
                  'Jeste li sigurni da želite ukloniti narudžbu kreiranu datuma: ${getDateFormat(e.datumNarudzbe)} !'),
              actions: [
                TextButton(
                  onPressed: () async {
                    try {
                      Navigator.of(context).pop();

                      await _narudzbeProvider.delete(e.narudzbeId);

                      fetchNarudzbe();
                    } on Exception catch (e) {
                      // ignore: use_build_context_synchronously
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text("Error"),
                          content: Text(e.toString()),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("OK"),
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

  ElevatedButton _buildPrikaziDetaljeNarudzbe(
      BuildContext context, Narudzbe e) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    NarudzbeDetaljiScreen(narudzba: e)));
      },
      style: ElevatedButton.styleFrom(
          elevation: 0.0, backgroundColor: Colors.transparent),
      child: const Text('Prikaži detalje'),
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
            controller: _brojNarudzbeController,
            decoration: const InputDecoration(
                labelText: "Broj narudžbe",
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
                    icon: const Icon(Icons.clear))),
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
                _brojNarudzbeController.text = "";
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
                'Kreiraj izvještaj u intervalu datuma Od - Do (opcionalno)',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.black54),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Datum Od:',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: FormBuilderDateTimePicker(
                      name: 'datumOd',
                      initialValue: _datumOd,
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
                            _formKey.currentState!.fields['datumOd']
                                ?.didChange(null);
                          },
                          icon: const Icon(Icons.clear),
                        ),
                      ),
                      inputType: InputType.date,
                      format: DateFormat("yyyy-MM-dd"),
                      onChanged: (DateTime? newDate) {
                        setState(() {
                          _datumOd = newDate;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 50.0,
                  ),
                  const Text(
                    'Datum Do:',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: FormBuilderDateTimePicker(
                      name: 'datumDo',
                      initialValue: _datumDo,
                      resetIcon: null,
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
                            _formKey.currentState!.fields['datumDo']
                                ?.didChange(null);
                          },
                          icon: const Icon(Icons.clear),
                        ),
                      ),
                      inputType: InputType.date,
                      format: DateFormat("yyyy-MM-dd"),
                      onChanged: (DateTime? newDate) {
                        setState(() {
                          _datumDo = newDate;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_datumOd == null && _datumDo == null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              NarudzbeIzvjestajScreen(
                            datumOd: null,
                            datumDo: null,
                          ),
                        ),
                      ).then((value) {
                        _formKey.currentState!.fields['datumDo']
                            ?.didChange(null);
                        _formKey.currentState!.fields['datumOd']
                            ?.didChange(null);
                      });
                    } else if (_datumOd == null || _datumDo == null) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                                'Greška prilikom kreiranja izvještaja !'),
                            content:
                                const Text('Molimo vas da unesete oba datuma.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    } else if (_datumOd!.isAfter(_datumDo!) ||
                        _datumOd!.isAtSameMomentAs(_datumDo!)) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                                'Greška prilikom kreiranja izvještaja !'),
                            content: const Text(
                                'Datum OD mora biti manji od datuma DO!'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              NarudzbeIzvjestajScreen(
                            datumOd: _datumOd,
                            datumDo: _datumDo,
                          ),
                        ),
                      ).then((value) {
                        _formKey.currentState!.fields['datumDo']
                            ?.didChange(null);
                        _formKey.currentState!.fields['datumOd']
                            ?.didChange(null);
                      });
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
}
