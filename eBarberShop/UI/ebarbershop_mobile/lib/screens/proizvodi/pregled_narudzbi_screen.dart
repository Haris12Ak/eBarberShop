import 'package:ebarbershop_mobile/models/narudzbe/narudzbe.dart';
import 'package:ebarbershop_mobile/models/search_result.dart';
import 'package:ebarbershop_mobile/providers/narudzbe_provider.dart';
import 'package:ebarbershop_mobile/screens/proizvodi/narudzbe_detalji_screen.dart';
import 'package:ebarbershop_mobile/utils/util.dart';
import 'package:ebarbershop_mobile/widgets/master_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PregledNarudzbiScreen extends StatefulWidget {
  const PregledNarudzbiScreen({super.key});

  @override
  State<PregledNarudzbiScreen> createState() => _PregledNarudzbiScreenState();
}

class _PregledNarudzbiScreenState extends State<PregledNarudzbiScreen> {
  late NarudzbeProvider _narudzbeProvider;
  SearchResult<Narudzbe>? narudzbeResult;
  bool isLoading = true;

  final _formKey = GlobalKey<FormBuilderState>();
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();

    _narudzbeProvider = context.read<NarudzbeProvider>();

    fetchNarudzbeByKorisnik();
  }

  Future fetchNarudzbeByKorisnik() async {
    narudzbeResult = await _narudzbeProvider
        .getNarudzbeByKorisnikId(Authorization.korisnikId!);

    narudzbeResult!.result
        .sort((a, b) => b.datumNarudzbe.compareTo(a.datumNarudzbe));

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> filter() async {
    var data = await _narudzbeProvider.getNarudzbeByKorisnikId(
        Authorization.korisnikId!,
        datumNarudzbe: _selectedDate);

    data.result.sort((a, b) => b.datumNarudzbe.compareTo(a.datumNarudzbe));

    setState(() {
      narudzbeResult = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: 'Pregled narudžbi',
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : FormBuilder(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.white54,
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
                  if (_selectedDate != null) const SizedBox(height: 8.0),
                  if (_selectedDate != null)
                    Text(
                      'Rezultati pretrage za datum: ${getDateFormat(_selectedDate)}',
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade700),
                    ),
                  const SizedBox(height: 15.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Datum',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade800),
                        ),
                        Text(
                          'Status',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade800),
                        ),
                        Text(
                          'Iznos',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade800),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 20.0,
                    thickness: 2.0,
                    color: Colors.grey.shade400,
                  ),
                  narudzbeResult!.result.isEmpty
                      ? Center(
                          child: Text(
                            'Nema rezultata pretrage !',
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade800),
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: narudzbeResult!.result.length,
                            itemBuilder: (BuildContext context, int index) {
                              var narudzba = narudzbeResult!.result[index];

                              DateTime datumOtkazivanjaNarudzbe =
                                  narudzbeResult!.result[index].datumNarudzbe
                                      .add(const Duration(days: 1));
                              return Container(
                                color: Colors.white,
                                margin: const EdgeInsets.only(bottom: 10.0),
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${getDateFormat(narudzba.datumNarudzbe)} | ${getTimeFormat(narudzba.datumNarudzbe)}',
                                          style: const TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        ),
                                        if (narudzba.otkazano != null &&
                                            narudzba.otkazano == false &&
                                            datumOtkazivanjaNarudzbe
                                                .isAfter(DateTime.now()))
                                          Container(
                                            padding: const EdgeInsets.all(4.0),
                                            color: Colors.grey,
                                            child: const Text(
                                              'In Progress',
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white),
                                            ),
                                          )
                                        else if (narudzba.otkazano != null &&
                                            narudzba.otkazano == true)
                                          Container(
                                            padding: const EdgeInsets.all(4.0),
                                            color: Colors.red,
                                            child: const Text(
                                              'Cancelled',
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white),
                                            ),
                                          )
                                        else if (narudzba.otkazano != null &&
                                            narudzba.otkazano == false)
                                          Container(
                                            padding: const EdgeInsets.all(4.0),
                                            color: Colors.green,
                                            child: const Text(
                                              'Completed',
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white),
                                            ),
                                          )
                                        else
                                          Container(
                                            padding: const EdgeInsets.all(4.0),
                                            color: Colors.grey,
                                            child: const Text(
                                              'Nepoznato',
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        Text(
                                          '${formatNumber(narudzba.ukupanIznos)} KM',
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.grey.shade800,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    if (datumOtkazivanjaNarudzbe
                                            .isAfter(DateTime.now()) &&
                                        narudzba.otkazano != null &&
                                        narudzba.otkazano == false)
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Vaša narudžba je uspješno izvršena !',
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(
                                            height: 5.0,
                                          ),
                                          const Text(
                                            'Ukoliko želite otkazati narudžbu to možete učiniti u roku od 24h, to jest do termina predviđenog za otkazivanje narudžbe.',
                                            style: TextStyle(fontSize: 15.0),
                                          ),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              const Text(
                                                'Otkaži narudžbu do: ',
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                '${getDateFormat(datumOtkazivanjaNarudzbe)} | ${getTimeFormat(datumOtkazivanjaNarudzbe)}',
                                                style: const TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          _buildOtkaziNarudzbu(
                                              context, narudzba)
                                        ],
                                      ),
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            elevation: 0.0,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15.0,
                                                vertical: 8.0),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        NarudzbeDetaljiScreen(
                                                            narudzba:
                                                                narudzba)));
                                          },
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text('Prikaži detalje'),
                                              SizedBox(width: 2.0),
                                              Icon(Icons.keyboard_arrow_right)
                                            ],
                                          )),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                ],
              ),
            ),
    );
  }

  ElevatedButton _buildOtkaziNarudzbu(BuildContext context, Narudzbe narudzba) {
    return ElevatedButton(
        onPressed: () {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  icon: const Icon(
                    Icons.info,
                    size: 35,
                  ),
                  content: const Text(
                    'Da li ste sigurni da želite otkazati narudžbu ?',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          await _narudzbeProvider
                              .otkaziNarudzbu(narudzba.narudzbeId)
                              .then((value) => Navigator.of(context).pop());

                          if (!context.mounted) {
                            return;
                          }

                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    icon: const Icon(
                                      Icons.check_circle_outline,
                                      color: Colors.green,
                                      size: 35,
                                    ),
                                    content: const Text(
                                      'Narudžba uspješno otkazana !',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();

                                          setState(() {
                                            fetchNarudzbeByKorisnik();
                                          });
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ));
                        } on Exception catch (e) {
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
                                  child: const Text("Close"),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 2.0,
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white),
                      child: const Text(
                        'Da',
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.0),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 2.0,
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white),
                      child: const Text(
                        'Ne',
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.0),
                      ),
                    ),
                  ],
                );
              });
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red.shade400,
            foregroundColor: Colors.white),
        child: const Text('Otkaži narudžbu'));
  }
}
