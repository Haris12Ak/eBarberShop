import 'package:ebarbershop_desktop/models/rezervacije/rezervacija_insert.dart';
import 'package:ebarbershop_desktop/models/termini/termini.dart';
import 'package:ebarbershop_desktop/models/uposlenik/uposlenik.dart';
import 'package:ebarbershop_desktop/providers/rezervacija_provider.dart';
import 'package:ebarbershop_desktop/providers/termini_provider.dart';
import 'package:ebarbershop_desktop/providers/uposlenik_provider.dart';
import 'package:ebarbershop_desktop/providers/usluga_provider.dart';
import 'package:ebarbershop_desktop/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RezervacijeTerminAddScreen extends StatefulWidget {
  const RezervacijeTerminAddScreen({super.key});

  @override
  State<RezervacijeTerminAddScreen> createState() =>
      _RezervacijeTerminAddScreenState();
}

class _RezervacijeTerminAddScreenState
    extends State<RezervacijeTerminAddScreen> {
  DateTime selectedDate = DateTime.now();

  List<Termini> _termini = [];
  List<Uposlenik> _uposlenici = [];

  late UslugaProvider _uslugaProvider;

  String? selectedUposlenikId;
  int? odabraniUposlenik;
  late int uslugaId;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    _uslugaProvider = context.read<UslugaProvider>();

    _loadTermine();
    _loadUposlenici();
    fetchUsluge();
  }

  Future fetchUsluge() async {
    var usluge = await _uslugaProvider.get();
    if (usluge.result.isNotEmpty) {
      setState(() {
        uslugaId = usluge.result.first.uslugaId;
        isLoading = false;
      });
    } else {
      setState(() {
        uslugaId = -1;
        isLoading = false;
      });
    }
  }

  Future<void> _loadTermine() async {
    var termini = await fetchTermine(context);
    setState(() {
      _termini = termini;
    });
  }

  Future<void> _loadUposlenici() async {
    var uposlenici = await fetchUposlenici(context);
    setState(() {
      _uposlenici = uposlenici;
    });
  }

  Future<List<Termini>> fetchTermine(BuildContext context) async {
    var terminiProvider = Provider.of<TerminiProvider>(context, listen: false);
    var termini = await terminiProvider.getTermine();
    return termini.result;
  }

  Future<List<Uposlenik>> fetchUposlenici(BuildContext context) async {
    var uposlenikProvider =
        Provider.of<UposlenikProvider>(context, listen: false);
    var uposlenici = await uposlenikProvider.get();

    return uposlenici.result;
  }

  int countingNumberOfTimes() {
    return ((17 - 8) * 60) ~/ 30;
  }

  DateTime countingTime(int index) {
    return DateTime(
            selectedDate.year, selectedDate.month, selectedDate.day, 8, 0)
        .add(Duration(minutes: index * 30));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Dodaj termin',
          style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.0,
              color: Colors.black54,
              fontStyle: FontStyle.italic),
        ),
        elevation: 0.0,
        backgroundColor: Colors.grey[300],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Odaberite termin koji želite označiti zauzetim !',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700]),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 300,
                      margin: const EdgeInsets.only(left: 110, right: 110),
                      child: FormBuilderDateTimePicker(
                        name: 'date',
                        textAlign: TextAlign.end,
                        initialValue: selectedDate,
                        decoration: InputDecoration(
                          fillColor: Colors.grey[700]!.withOpacity(0.1),
                          filled: true,
                          contentPadding:
                              const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                          prefixIcon: const Icon(Icons.date_range),
                          prefixText: 'Datum:',
                          floatingLabelStyle: const TextStyle(
                            color: Colors.black54,
                            fontSize: 17.0,
                            fontWeight: FontWeight.w600,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                        ),
                        inputType: InputType.date,
                        firstDate: DateTime.now(),
                        format: DateFormat("yyyy-MM-dd"),
                        onChanged: (DateTime? newDate) {
                          setState(() {
                            selectedDate = newDate!;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 100, right: 100),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 9,
                        ),
                        itemCount: countingNumberOfTimes(),
                        itemBuilder: (context, index) {
                          final time = countingTime(index);
                          bool isZauzetTermin =
                              _termini.any((termin) => termin.vrijeme == time);
                          return GestureDetector(
                            onTap: () {
                              if (isZauzetTermin) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    showCloseIcon: true,
                                    duration: Durations.extralong4,
                                    content: Text(
                                      "Odabrani termin ${formatDate(time)} je zauzet !.",
                                      style: const TextStyle(fontSize: 15.0),
                                    ),
                                  ),
                                );
                              } else if (!isZauzetTermin &&
                                  time.isBefore(DateTime.now())) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    showCloseIcon: true,
                                    backgroundColor: Colors.red.shade900,
                                    content: Text(
                                      "Vrijeme termina ${getTimeFormat(time)} h za datum ${getDateFormat(time)} je isteklo. Moilmo Vas da odaberete drugo vrijeme termina !",
                                      style: const TextStyle(
                                          fontSize: 15.0, color: Colors.white),
                                    ),
                                  ),
                                );
                              } else {
                                showModalBottomSheet(
                                  showDragHandle: true,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return StatefulBuilder(
                                      builder: (BuildContext context,
                                          StateSetter setState) {
                                        return Container(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Datum:',
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    color: Colors.grey[700],
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Text(
                                                getDateFormat(selectedDate),
                                                style: const TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              const SizedBox(
                                                height: 15.0,
                                              ),
                                              Text(
                                                'Vrijeme:',
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    color: Colors.grey[700],
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Text(
                                                getTimeFormat(time),
                                                style: const TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              const SizedBox(
                                                height: 15.0,
                                              ),
                                              Text(
                                                'Odaberite uposlenika:',
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    color: Colors.grey[700],
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              const SizedBox(
                                                height: 8.0,
                                              ),
                                              DropdownButtonFormField<String>(
                                                value: selectedUposlenikId,
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    selectedUposlenikId =
                                                        newValue!;
                                                    odabraniUposlenik =
                                                        int.tryParse(
                                                            selectedUposlenikId!);
                                                  });
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                  prefixIcon:
                                                      Icon(Icons.person),
                                                  border: OutlineInputBorder(),
                                                ),
                                                items: _uposlenici.map<
                                                    DropdownMenuItem<String>>(
                                                  (Uposlenik uposlenik) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: uposlenik
                                                          .uposlenikId
                                                          .toString(),
                                                      child: Text(
                                                          '${uposlenik.ime} ${uposlenik.prezime}'),
                                                    );
                                                  },
                                                ).toList(),
                                              ),
                                              const SizedBox(
                                                height: 50.0,
                                              ),
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: ElevatedButton.icon(
                                                  onPressed: selectedUposlenikId !=
                                                              null &&
                                                          selectedUposlenikId !=
                                                              ""
                                                      ? () async {
                                                          var rezervacijeProvider =
                                                              Provider.of<
                                                                      RezervacijaProvider>(
                                                                  context,
                                                                  listen:
                                                                      false);

                                                          RezervacijaInsert
                                                              request =
                                                              RezervacijaInsert(
                                                                  selectedDate,
                                                                  time,
                                                                  true,
                                                                  Authorization
                                                                      .korisnikId!,
                                                                  odabraniUposlenik!,
                                                                  uslugaId);

                                                          try {
                                                            await rezervacijeProvider
                                                                .insert(
                                                                    request);

                                                            if (!context
                                                                .mounted) {
                                                              return;
                                                            }

                                                            showDialog(
                                                                barrierDismissible:
                                                                    false,
                                                                context:
                                                                    context,
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    AlertDialog(
                                                                      title: const Text(
                                                                          'Poruka'),
                                                                      content: Text(
                                                                          'Termin ${getDateFormat(selectedDate)} ${getTimeFormat(time)} uspješno označen zauzetim.'),
                                                                      actions: [
                                                                        TextButton(
                                                                          onPressed:
                                                                              () async {
                                                                            await _loadTermine();

                                                                            if (!context.mounted) {
                                                                              return;
                                                                            }

                                                                            Navigator.of(context).pop();
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                          child:
                                                                              const Text('OK'),
                                                                        ),
                                                                      ],
                                                                    ));
                                                          } on Exception catch (e) {
                                                            // ignore: use_build_context_synchronously
                                                            showDialog(
                                                              barrierDismissible:
                                                                  false,
                                                              context: context,
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  AlertDialog(
                                                                title:
                                                                    const Text(
                                                                        "Error"),
                                                                content: Text(e
                                                                    .toString()),
                                                                actions: [
                                                                  TextButton(
                                                                      onPressed: () =>
                                                                          Navigator.pop(
                                                                              context),
                                                                      child: const Text(
                                                                          "Close"))
                                                                ],
                                                              ),
                                                            );
                                                          }
                                                        }
                                                      : null,
                                                  icon: const Icon(
                                                      Icons.save_alt),
                                                  label: const Text(
                                                    'Spremi',
                                                    style: TextStyle(
                                                        fontSize: 16.0),
                                                  ),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    elevation: 8.0,
                                                    shape:
                                                        const BeveledRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .zero),
                                                    backgroundColor:
                                                        Colors.blueGrey,
                                                    foregroundColor:
                                                        Colors.white,
                                                    minimumSize:
                                                        const Size(100, 50),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.all(8.0),
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: isZauzetTermin
                                      ? Colors.red[900]!.withOpacity(0.2)
                                      : Colors.green[900]!.withOpacity(0.2),
                                ),
                                borderRadius: BorderRadius.circular(8),
                                color: isZauzetTermin
                                    ? Colors.red[900]!.withOpacity(0.2)
                                    : Colors.green[900]!.withOpacity(0.2),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  isZauzetTermin
                                      ? const Icon(Icons.event_busy,
                                          color: Colors.red, size: 26)
                                      : const Icon(Icons.event_available,
                                          color: Colors.green, size: 26),
                                  const SizedBox(width: 8),
                                  Text(
                                    time.toString().substring(11, 16),
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey[700]),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
