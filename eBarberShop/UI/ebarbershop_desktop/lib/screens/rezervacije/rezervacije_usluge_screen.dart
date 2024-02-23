import 'package:ebarbershop_desktop/models/rezervacije/usluge_rezervacije_info.dart';
import 'package:ebarbershop_desktop/models/search_result.dart';
import 'package:ebarbershop_desktop/models/usluga/usluga.dart';
import 'package:ebarbershop_desktop/providers/rezervacija_provider.dart';
import 'package:ebarbershop_desktop/providers/rezervacija_usluge_provider.dart';
import 'package:ebarbershop_desktop/utils/util.dart';
import 'package:ebarbershop_desktop/widgets/button_back_widget.dart';
import 'package:ebarbershop_desktop/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class RezervacijeUslugeScreen extends StatefulWidget {
  Usluga usluga;
  RezervacijeUslugeScreen({super.key, required this.usluga});

  @override
  State<RezervacijeUslugeScreen> createState() =>
      _RezervacijeUslugeScreenState();
}

class _RezervacijeUslugeScreenState extends State<RezervacijeUslugeScreen> {
  late RezervacijaUslugeProvider _rezervacijaUslugeProvider;
  late RezervacijaProvider _rezervacijaProvider;
  SearchResult<UslugeRezervacijeInfo>? uslugeRezervacijeInfoResult;

  bool isLoading = true;

  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _rezervacijaProvider = context.read<RezervacijaProvider>();

    fetchRezervacije();
  }

  Future fetchRezervacije() async {
    _rezervacijaUslugeProvider =
        Provider.of<RezervacijaUslugeProvider>(context, listen: false);

    uslugeRezervacijeInfoResult =
        await _rezervacijaUslugeProvider.GetRezervacije(widget.usluga.uslugaId);

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: 'Rezervacije',
      selectedOption: 'Rezervacije',
      child: isLoading
          ? Container()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const ButtonBackWidget(),
                const SizedBox(
                  height: 15.0,
                ),
                _buildPrikazUsluge(),
                const SizedBox(
                  height: 25.0,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    label: const Text(
                      'Dodaj termin',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 300,
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
                            )),
                        inputType: InputType.date,
                        format: DateFormat("yyyy-MM-dd"),
                        onChanged: (DateTime? newDate) {
                          setState(() {
                            _selectedDate = newDate;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    ElevatedButton.icon(
                      onPressed: () async {
                        var data =
                            await _rezervacijaUslugeProvider.GetRezervacije(
                                widget.usluga.uslugaId,
                                filter: {'datumTermina': _selectedDate});

                        setState(() {
                          uslugeRezervacijeInfoResult = data;
                        });
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
                    const SizedBox(
                      width: 20.0,
                    ),
                    ElevatedButton.icon(
                      onPressed: () async {
                        setState(() {
                          _selectedDate = null;
                        });

                        var data =
                            await _rezervacijaUslugeProvider.GetRezervacije(
                                widget.usluga.uslugaId);

                        setState(() {
                          uslugeRezervacijeInfoResult = data;
                        });
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
                  ],
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(15.0),
                      child: _buildForm(context),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                  child: Text(
                    'Ukupno podataka: ${uslugeRezervacijeInfoResult?.count}',
                    style: const TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.0,
                        fontSize: 15.0),
                  ),
                ),
              ],
            ),
    );
  }

  DataTable _buildForm(BuildContext context) {
    return DataTable(
        dataTextStyle: const TextStyle(fontSize: 16.0),
        decoration: const BoxDecoration(color: Colors.white70),
        columns: const <DataColumn>[
          DataColumn(
            label: Expanded(
              child: Text(
                'Rezervacija ID',
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
                'Datum rezervacije',
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
                'Ime i prezime klijenta',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.black54),
              ),
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
        rows: uslugeRezervacijeInfoResult?.result
                .map((UslugeRezervacijeInfo e) => DataRow(cells: <DataCell>[
                      DataCell(Text(e.rezervacijaId.toString())),
                      DataCell(Text(getDateFormat(e.datumRezervacije))),
                      DataCell(Text(getTimeFormat(e.vrijemeRezervacije))),
                      DataCell(Text('${e.imeKlijenta} ${e.prezimeKlijenta}')),
                      DataCell(
                        _buildDeleteTermin(context, e),
                      )
                    ]))
                .toList() ??
            []);
  }

  IconButton _buildDeleteTermin(BuildContext context, UslugeRezervacijeInfo e) {
    return IconButton(
      tooltip: 'Ukloni termin',
      onPressed: () {
        try {
          // ignore: use_build_context_synchronously
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Potvrda'),
              content: Text(
                  'Jeste li sigurni da želite ukloniti termin kreiran datuma: ${getDateFormat(e.datumRezervacije)}, vrijeme ${getTimeFormat(e.vrijemeRezervacije)} !'),
              actions: [
                TextButton(
                  onPressed: () async {
                    await _rezervacijaProvider.delete(e.rezervacijaId);

                    fetchRezervacije();
                    Navigator.of(context).pop();
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
      icon: const Icon(Icons.delete_forever),
    );
  }

  Container _buildPrikazUsluge() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        gradient: const LinearGradient(colors: [
          Color.fromRGBO(177, 177, 177, 0.856),
          Color.fromRGBO(255, 255, 255, 0.226)
        ]),
      ),
      padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Opacity(
                  opacity: 0.6,
                  child: Image(
                    image: AssetImage('assets/images/image1.jpg'),
                    width: 170,
                    height: 170,
                  )),
              const SizedBox(
                width: 40.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Usluga:',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2.0,
                        color: Colors.black54),
                  ),
                  Text(
                    widget.usluga.naziv,
                    style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.0,
                        color: Colors.black54),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    'Cijena:',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2.0,
                        color: Colors.black54),
                  ),
                  Text(
                    '${formatNumber(widget.usluga.cijena)} KM',
                    style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.0,
                        color: Colors.black54),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    'Trajanje:',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2.0,
                        color: Colors.black54),
                  ),
                  Text(
                    '${widget.usluga.trajanje} min',
                    style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.0,
                        color: Colors.black54),
                  ),
                ],
              ),
            ],
          ),
          Divider(
            color: Colors.grey[50],
            height: 30,
          ),
          const Text(
            'Opis:',
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                letterSpacing: 2.0,
                color: Colors.black54),
          ),
          Text(
            widget.usluga.opis != null && widget.usluga.opis != ""
                ? '${widget.usluga.opis}'
                : '---',
            style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.0,
                color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
