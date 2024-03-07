import 'package:ebarbershop_desktop/models/narudzbe/narudzbe.dart';
import 'package:ebarbershop_desktop/models/search_result.dart';
import 'package:ebarbershop_desktop/providers/narudzbe_provider.dart';
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

  DateTime? _selectedDate;
  final TextEditingController _brojNarudzbeController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _narudzbeProvider = context.read<NarudzbeProvider>();

    fetchNarudzbe();
  }

  Future fetchNarudzbe() async {
    var data = await _narudzbeProvider.get();

    setState(() {
      narudzbeResult = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: 'Narudžbe',
      selectedOption: 'Narudzbe',
      child: isLoading
          ? Container()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 500,
                      child: TextField(
                        controller: _brojNarudzbeController,
                        decoration: const InputDecoration(
                          labelText: "Broj narudžbe",
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
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
                        var data = await _narudzbeProvider.get(filter: {
                          'datumNarudzbe': _selectedDate,
                          'brojNarudzbe': _brojNarudzbeController.text
                        });

                        setState(() {
                          narudzbeResult = data;
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
                          _brojNarudzbeController.text = "";
                          _selectedDate = null;
                        });

                        var data = await _narudzbeProvider.get();

                        setState(() {
                          narudzbeResult = data;
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
                  height: 40.0,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: DataTable(
                        dataTextStyle: const TextStyle(fontSize: 16.0),
                        decoration: const BoxDecoration(color: Colors.white70),
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
                              'Akcije',
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black54),
                            ),
                          ),
                        ],
                        rows: narudzbeResult?.result
                                .map((Narudzbe e) => DataRow(cells: <DataCell>[
                                      DataCell(Text(
                                          '${e.imeKorisnika} ${e.prezimeKorisnika}')),
                                      DataCell(Text(e.brojNarudzbe)),
                                      DataCell(
                                          Text(getDateFormat(e.datumNarudzbe))),
                                      DataCell(
                                          Text(getTimeFormat(e.datumNarudzbe))),
                                      DataCell(
                                        Row(
                                          children: [
                                            IconButton(
                                                tooltip: 'Detalji/Uredi',
                                                onPressed: () {},
                                                icon: const Icon(Icons.edit)),
                                            const SizedBox(
                                              width: 10.0,
                                            ),
                                            IconButton(
                                                tooltip: 'Obriši',
                                                onPressed: () {},
                                                icon: const Icon(
                                                    Icons.delete_forever))
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
    );
  }
}
