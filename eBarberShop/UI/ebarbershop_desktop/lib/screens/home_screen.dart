import 'package:ebarbershop_desktop/models/korisnik/korisnik.dart';
import 'package:ebarbershop_desktop/models/rezervacije/rezervacija.dart';
import 'package:ebarbershop_desktop/models/search_result.dart';
import 'package:ebarbershop_desktop/models/uposlenik/uposlenik.dart';
import 'package:ebarbershop_desktop/models/usluga/usluga.dart';
import 'package:ebarbershop_desktop/providers/korisnik_provider.dart';
import 'package:ebarbershop_desktop/providers/rezervacija_provider.dart';
import 'package:ebarbershop_desktop/providers/uposlenik_provider.dart';
import 'package:ebarbershop_desktop/providers/usluga_provider.dart';
import 'package:ebarbershop_desktop/utils/util.dart';
import 'package:ebarbershop_desktop/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late KorisnikProvider _korisnikProvider;
  late UslugaProvider _uslugaProvider;
  late UposlenikProvider _uposlenikProvider;
  late RezervacijaProvider _rezervacijaProvider;

  SearchResult<Korisnik>? korisnici;
  SearchResult<Usluga>? usluge;
  SearchResult<Uposlenik>? uposlenici;
  SearchResult<Rezervacija>? rezervacije;
  List<Rezervacija> terminiZaDanas = [];
  List<Rezervacija> terminiZaSutra = [];
  List<Rezervacija> filtriraniPodaci = [];

  bool isLoading = true;

  DateTime today = DateTime.now();
  DateTime tomorrow = DateTime.now().add(const Duration(days: 1));

  String? selectedUsluga;
  String? selectedNazivUsluge = "";

  String? selectedUposlenik;
  String? selectedImePrezimeUposlenika = "";

  @override
  void initState() {
    super.initState();

    _korisnikProvider = context.read<KorisnikProvider>();
    _uslugaProvider = context.read<UslugaProvider>();
    _uposlenikProvider = context.read<UposlenikProvider>();
    _rezervacijaProvider = context.read<RezervacijaProvider>();

    fetchData();
  }

  Future fetchData() async {
    korisnici = await _korisnikProvider.get();
    usluge = await _uslugaProvider.get();
    uposlenici = await _uposlenikProvider.get();
    rezervacije = await _rezervacijaProvider.get(filter: {
      'IsUslugaIncluded': true,
      'IsKorisnikIncluded': true,
      'IsUposlenikIncluded': true
    });

    if (rezervacije!.result.isNotEmpty) {
      for (var item in rezervacije!.result) {
        if (getDateFormat(item.datum) == getDateFormat(today)) {
          terminiZaDanas.add(item);
        } else if (getDateFormat(item.datum) == getDateFormat(tomorrow)) {
          terminiZaSutra.add(item);
        }
      }
    }

    terminiZaDanas.sort((a, b) => a.vrijeme.compareTo(b.vrijeme));

    if (mounted) {
      setState(() {
        filtriraniPodaci = terminiZaDanas;
        isLoading = false;
      });
    }
  }

  void getFilteredData(String uslugaNaziv, String imePrezimeUposlenika) {
    List<Rezervacija> filteredList = [];

    if (uslugaNaziv != "" && imePrezimeUposlenika != "") {
      for (var item in terminiZaDanas) {
        if (item.nazivUsluge == uslugaNaziv &&
            ('${item.uposlenikIme} ${item.uposlenikPrezime}') ==
                imePrezimeUposlenika) {
          filteredList.add(item);
        }
      }
    } else if (uslugaNaziv != "") {
      for (var item in terminiZaDanas) {
        if (item.nazivUsluge == uslugaNaziv) {
          filteredList.add(item);
        }
      }
    } else if (imePrezimeUposlenika != "") {
      for (var item in terminiZaDanas) {
        if (('${item.uposlenikIme} ${item.uposlenikPrezime}') ==
            imePrezimeUposlenika) {
          filteredList.add(item);
        }
      }
    } else {
      filteredList = terminiZaDanas;
    }

    setState(() {
      filtriraniPodaci = filteredList;
    });
  }

  bool isAktivan(String datum) {
    var dateTime = DateTime.parse(datum);
    return dateTime.isBefore(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: 'Početna',
      selectedOption: 'Pocetna',
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text('Pregled',
                    style: TextStyle(
                        fontSize: 22.0,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.0)),
                const SizedBox(height: 20.0),
                _buildOverview(),
                Divider(
                  height: 40.0,
                  color: Colors.grey.shade600,
                ),
                Text('Termini  |  ${formatDate1(today)}',
                    style: const TextStyle(
                        fontSize: 22.0,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.0)),
                const SizedBox(height: 20.0),
                _buildFilter(),
              ],
            ),
    );
  }

  Expanded _buildFilter() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                  decoration: const BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                      )),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                          ),
                          child: DropdownButton(
                            value: selectedUposlenik,
                            items: [
                              const DropdownMenuItem(
                                value: null,
                                child: Text('Uposlenici (All)'),
                              ),
                              ...uposlenici?.result
                                      .map(
                                        (item) => DropdownMenuItem(
                                          value: item.uposlenikId.toString(),
                                          child: Text(
                                              '${item.ime} ${item.prezime}'),
                                        ),
                                      )
                                      .toList() ??
                                  [],
                            ],
                            onChanged: (item) async {
                              setState(() {
                                selectedUposlenik = item as String?;
                              });

                              if (item == null) {
                                setState(() {
                                  selectedImePrezimeUposlenika = "";
                                });

                                getFilteredData(selectedNazivUsluge!,
                                    selectedImePrezimeUposlenika!);
                              } else {
                                final selectedUposlenik = uposlenici?.result
                                    .firstWhere((uposlenik) =>
                                        uposlenik.uposlenikId.toString() ==
                                        item);

                                setState(() {
                                  selectedImePrezimeUposlenika =
                                      '${selectedUposlenik?.ime} ${selectedUposlenik?.prezime}';
                                });

                                getFilteredData(selectedNazivUsluge!,
                                    selectedImePrezimeUposlenika!);
                              }
                            },
                            isExpanded: true,
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            dropdownColor: Colors.grey.shade200,
                            focusColor: Colors.grey.shade200,
                            icon: const Icon(Icons.filter_list),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20.0),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                          ),
                          child: DropdownButton(
                            value: selectedUsluga,
                            items: [
                              const DropdownMenuItem(
                                value: null,
                                child: Text('Usluge (All)'),
                              ),
                              ...usluge?.result
                                      .map(
                                        (item) => DropdownMenuItem(
                                          value: item.uslugaId.toString(),
                                          child: Text(item.naziv),
                                        ),
                                      )
                                      .toList() ??
                                  [],
                            ],
                            onChanged: (item) {
                              setState(() {
                                selectedUsluga = item as String?;
                              });

                              if (item == null) {
                                setState(() {
                                  selectedNazivUsluge = "";
                                });

                                getFilteredData(selectedNazivUsluge!,
                                    selectedImePrezimeUposlenika!);
                              } else {
                                final selectedUsluga = usluge?.result
                                    .firstWhere((usluga) =>
                                        usluga.uslugaId.toString() == item);

                                setState(() {
                                  selectedNazivUsluge = selectedUsluga!.naziv;
                                });

                                getFilteredData(selectedNazivUsluge!,
                                    selectedImePrezimeUposlenika!);
                              }
                            },
                            isExpanded: true,
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            dropdownColor: Colors.grey.shade200,
                            focusColor: Colors.grey.shade200,
                            icon: const Icon(Icons.filter_list),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
                    decoration: const BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                    child: terminiZaDanas.isEmpty
                        ? const Center(
                            child: Text(
                              'Nema termina za danas!',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          )
                        : filtriraniPodaci.isEmpty
                            ? const Center(
                                child: Text(
                                  'Nema rezultata pretrage!',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              )
                            : _buildListOfAppointmentsForToday(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20.0),
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.access_time_filled,
                              size: 35.0,
                              color: Colors.grey.shade800,
                            ),
                            Text(
                              getDateFormat(today),
                              style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade600),
                            )
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          terminiZaDanas.length.toString(),
                          style: const TextStyle(
                              fontSize: 35.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                        const Divider(
                          color: Colors.white54,
                          height: 20.0,
                        ),
                        const Text(
                          'Termini za danas',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 40.0,
                    color: Colors.grey.shade600,
                  ),
                  Container(
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.access_time_outlined,
                              size: 35.0,
                              color: Colors.grey.shade800,
                            ),
                            Text(
                              getDateFormat(tomorrow),
                              style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade600),
                            )
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          terminiZaSutra.length.toString(),
                          style: const TextStyle(
                              fontSize: 35.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                        const Divider(
                          color: Colors.white54,
                          height: 20.0,
                        ),
                        const Text(
                          'Termini za sutra',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  ListView _buildListOfAppointmentsForToday() {
    return ListView.builder(
      itemCount: filtriraniPodaci.length,
      itemBuilder: (BuildContext context, int index) {
        Rezervacija rezervacija = filtriraniPodaci[index];
        return Container(
          color: Colors.grey.shade100,
          margin: const EdgeInsets.only(top: 15.0),
          child: ListTile(
            title: Row(
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: 'Klijent: ',
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey.shade900,
                                fontWeight: FontWeight.w500)),
                        TextSpan(
                            text:
                                '${rezervacija.klijentIme ?? ""} ${rezervacija.klijentPrezime ?? ""}',
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 20.0),
                const Text('|'),
                const SizedBox(width: 20.0),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: 'Uposlenik: ',
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey.shade900,
                                fontWeight: FontWeight.w500)),
                        TextSpan(
                            text:
                                '${rezervacija.uposlenikIme ?? ""} ${rezervacija.uposlenikPrezime ?? ""}',
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 20.0),
                const Text('|'),
                const SizedBox(width: 20.0),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: 'Usluga: ',
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey.shade900,
                                fontWeight: FontWeight.w500)),
                        TextSpan(
                            text: rezervacija.nazivUsluge ?? "",
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 20.0),
                const Text('|'),
                const SizedBox(width: 20.0),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: 'Vrijeme: ',
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey.shade900,
                                fontWeight: FontWeight.w500)),
                        TextSpan(
                            text: getTimeFormat(rezervacija.vrijeme),
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 20.0),
                const Text('|'),
                const SizedBox(width: 20.0),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                isAktivan(rezervacija.vrijeme.toString())
                    ? Icon(
                        Icons.timer_off_outlined,
                        color: Colors.red.shade900,
                      )
                    : Icon(
                        Icons.access_time,
                        color: Colors.blue.shade900,
                      ),
              ],
            ),
          ),
        );
      },
    );
  }

  Row _buildOverview() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: Colors.amber.shade400,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.people,
                  size: 35.0,
                  color: Colors.grey.shade800,
                ),
                const SizedBox(height: 10.0),
                Text(
                  korisnici!.count.toString(),
                  style: const TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
                const Divider(
                  color: Colors.white54,
                  height: 20.0,
                ),
                const Text(
                  'Ukupno klijenata',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 20.0),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: Colors.blue.shade400,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.people_outline_outlined,
                  size: 35.0,
                  color: Colors.grey.shade800,
                ),
                const SizedBox(height: 10.0),
                Text(
                  uposlenici!.count.toString(),
                  style: const TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
                const Divider(
                  color: Colors.white54,
                  height: 20.0,
                ),
                const Text(
                  'Ukupno uposlenika',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 20.0),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: Colors.red.shade400,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.miscellaneous_services,
                  size: 35.0,
                  color: Colors.grey.shade800,
                ),
                const SizedBox(height: 10.0),
                Text(
                  usluge!.count.toString(),
                  style: const TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
                const Divider(
                  color: Colors.white54,
                  height: 20.0,
                ),
                const Text(
                  'Ukupno usluga',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 20.0),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: Colors.green.shade400,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.date_range,
                  size: 35.0,
                  color: Colors.grey.shade800,
                ),
                const SizedBox(height: 10.0),
                Text(
                  rezervacije!.count.toString(),
                  style: const TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
                const Divider(
                  color: Colors.white54,
                  height: 20.0,
                ),
                const Text(
                  'Ukupno rezervacija',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
