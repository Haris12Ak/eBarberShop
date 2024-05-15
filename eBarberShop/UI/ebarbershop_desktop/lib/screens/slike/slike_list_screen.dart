import 'package:ebarbershop_desktop/models/search_result.dart';
import 'package:ebarbershop_desktop/models/slike/slike.dart';
import 'package:ebarbershop_desktop/providers/slike_provider.dart';
import 'package:ebarbershop_desktop/screens/slike/slike_add_edit_screen.dart';
import 'package:ebarbershop_desktop/utils/util.dart';
import 'package:ebarbershop_desktop/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SlikeListScreen extends StatefulWidget {
  const SlikeListScreen({super.key});

  @override
  State<SlikeListScreen> createState() => _SlikeListScreenState();
}

class _SlikeListScreenState extends State<SlikeListScreen> {
  late SlikeProvider _slikeProvider;
  SearchResult<Slike>? slikeSearchResult;
  bool isLoading = true;
  DateTime? _selectedDate;

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    _slikeProvider = context.read<SlikeProvider>();

    fetchSlike();
  }

  Future fetchSlike() async {
    slikeSearchResult = await _slikeProvider.get();

    slikeSearchResult!.result.sort((a, b) => b.slikeId.compareTo(a.slikeId));

    setState(() {
      isLoading = false;
    });
  }

  Future<void> filter() async {
    var data = await _slikeProvider.get(filter: {
      'DatumObjave': _selectedDate,
    });

    data.result.sort((a, b) => b.slikeId.compareTo(a.slikeId));

    setState(() {
      slikeSearchResult = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: 'Slike',
      selectedOption: 'Slike',
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
                            builder: (context) => SlikeAddEditScreen(),
                          ),
                        )
                            .then((_) {
                          fetchSlike();
                        });
                      },
                      icon: const Icon(Icons.add),
                      label: const Text(
                        'Dodaj sliku',
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
                  const SizedBox(
                    height: 25.0,
                  ),
                  _buildSearch(),
                  const SizedBox(
                    height: 20.0,
                  ),
                  _buildForm(context),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                    child: Text(
                      'Ukupno podataka: ${slikeSearchResult?.count}',
                      style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.0,
                          fontSize: 15.0),
                    ),
                  ),
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
          flex: 5,
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

  Expanded _buildForm(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: DataTable(
            dividerThickness: 2.0,
            dataRowMaxHeight: 100,
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
                    'Slika',
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
                    'Opis',
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
            rows: slikeSearchResult?.result
                    .map((Slike e) => DataRow(cells: <DataCell>[
                          DataCell(Text(e.slikeId.toString())),
                          DataCell(e.slika != ""
                              ? SizedBox(
                                  width: 80,
                                  height: 80,
                                  child: imageFromBase64String(e.slika),
                                )
                              : const Text('')),
                          DataCell(
                            SizedBox(
                              width: 150,
                              child: Text(formatDate(e.datumPostavljanja)),
                            ),
                          ),
                          DataCell(Text(
                            e.opis ?? "",
                            maxLines: 2,
                            style: const TextStyle(
                              overflow: TextOverflow.fade,
                            ),
                          )),
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
                                              SlikeAddEditScreen(
                                            slika: e,
                                          ),
                                        ),
                                      )
                                          .then((_) {
                                        fetchSlike();
                                      });
                                    },
                                    icon: const Icon(Icons.edit)),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                _buildDeleteImage(context, e),
                              ],
                            ),
                          )
                        ]))
                    .toList() ??
                []),
      ),
    );
  }

  IconButton _buildDeleteImage(BuildContext context, Slike e) {
    return IconButton(
        tooltip: 'Obriši',
        onPressed: () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Potvrda'),
              content: Text(
                  'Jeste li sigurni da želite ukloniti sliku objavljenu datuma: ${formatDate(e.datumPostavljanja)} !'),
              actions: [
                TextButton(
                  onPressed: () async {
                    try {
                      await _slikeProvider
                          .delete(e.slikeId)
                          .then((value) => Navigator.of(context).pop());

                      if (!context.mounted) {
                        return;
                      }

                      fetchSlike();
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
