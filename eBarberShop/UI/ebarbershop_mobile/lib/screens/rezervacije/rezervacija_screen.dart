import 'package:ebarbershop_mobile/models/rezervacija/rezervacija_insert_request.dart';
import 'package:ebarbershop_mobile/models/termini/termini.dart';
import 'package:ebarbershop_mobile/models/uposlenik/uposlenik.dart';
import 'package:ebarbershop_mobile/models/usluga/usluga.dart';
import 'package:ebarbershop_mobile/providers/rezervacija_provider.dart';
import 'package:ebarbershop_mobile/providers/termini_provider.dart';
import 'package:ebarbershop_mobile/providers/uposlenik_provider.dart';
import 'package:ebarbershop_mobile/screens/rezervacije/termini_info_screen.dart';
import 'package:ebarbershop_mobile/utils/util.dart';
import 'package:ebarbershop_mobile/widgets/master_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

// ignore: must_be_immutable
class RezervacijaScreen extends StatefulWidget {
  Usluga usluga;
  RezervacijaScreen({super.key, required this.usluga});

  @override
  State<RezervacijaScreen> createState() => _RezervacijaScreenState();
}

class _RezervacijaScreenState extends State<RezervacijaScreen> {
  List<Termini> _termini = [];
  List<Uposlenik> _uposlenici = [];
  bool isLoading = true;
  final String _emailKorisnika = Authorization.email!;

  DateTime today = DateTime.now();

  int? selectedUsposlenik = -1;

  final TextEditingController _emailController = TextEditingController();
  bool _isEmailValid = true;

  static final TextStyle _customLabelStyle = TextStyle(
      fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.grey.shade800);

  @override
  void initState() {
    super.initState();

    _loadTermine();
    _loadUposlenike();
  }

  Future<void> _loadTermine() async {
    var termini = await fetchTermine(context);

    if (mounted) {
      setState(() {
        _termini = termini;
        isLoading = false;
      });
    }
  }

  Future<List<Termini>> fetchTermine(BuildContext context) async {
    var terminiProvider = Provider.of<TerminiProvider>(context, listen: false);
    var termini = await terminiProvider.getTermine();
    return termini.result;
  }

  Future<void> _loadUposlenike() async {
    var uposlenici = await fetchUposlenike(context);
    if (mounted) {
      setState(() {
        _uposlenici = uposlenici;
        isLoading = false;
      });
    }
  }

  Future<List<Uposlenik>> fetchUposlenike(BuildContext context) async {
    var uposlenikProvider =
        Provider.of<UposlenikProvider>(context, listen: false);
    var uposlenici = await uposlenikProvider.get();
    return uposlenici.result;
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      today = selectedDay;
    });
  }

  int countingNumberOfTimes() {
    return ((17 - 8) * 60) ~/ 30;
  }

  DateTime countingTime(int index) {
    return DateTime(today.year, today.month, today.day, 8, 0)
        .add(Duration(minutes: index * 30));
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: 'Rezervacija',
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Odaberite datum', style: _customLabelStyle),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const TerminiInfroScreen()))
                            .then((value) async => await _loadTermine());
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0.0,
                          backgroundColor: Colors.grey.withOpacity(0.3),
                          side: const BorderSide(
                            color: Colors.black26,
                          )),
                      icon: Icon(
                        Icons.date_range,
                        color: Colors.grey.shade800,
                      ),
                      label: Text(
                        'Moji termini',
                        style: _customLabelStyle,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 7.0),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: TableCalendar(
                    headerVisible: true,
                    firstDay: DateTime.now(),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: today,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    rowHeight: 48.0,
                    headerStyle: const HeaderStyle(
                        formatButtonVisible: false, titleCentered: true),
                    availableGestures: AvailableGestures.all,
                    calendarStyle: CalendarStyle(
                      defaultTextStyle: const TextStyle(color: Colors.black),
                      weekendTextStyle: TextStyle(color: Colors.red.shade300),
                    ),
                    selectedDayPredicate: (day) => isSameDay(day, today),
                    onDaySelected: _onDaySelected,
                    enabledDayPredicate: (day) =>
                        day.weekday != DateTime.sunday,
                  ),
                ),
                const SizedBox(height: 15.0),
                Text('Odaberite vrijeme', style: _customLabelStyle),
                const SizedBox(height: 7.0),
                Expanded(
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 4,
                              mainAxisSpacing: 8.0,
                              crossAxisSpacing: 8.0),
                      itemCount: countingNumberOfTimes(),
                      itemBuilder: (BuildContext context, int index) {
                        final time = countingTime(index);
                        bool isZauzetTermin =
                            _termini.any((termin) => termin.vrijeme == time);
                        return GestureDetector(
                          onTap: () {
                            if (!isZauzetTermin) {
                              _buildRezervacijaTermina(context, time);
                            }
                          },
                          child: _buildPrikazTermina(isZauzetTermin, time),
                        );
                      }),
                ),
              ],
            ),
    );
  }

  Future<dynamic> _buildRezervacijaTermina(
      BuildContext context, DateTime time) {
    return showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Container(
                        color: Colors.grey.withOpacity(0.5),
                        width: double.infinity,
                        height: 56.0,
                        child: Center(
                          child: Text(widget.usluga.naziv,
                              style: _customLabelStyle),
                        ),
                      ),
                      Positioned(
                        left: 0.0,
                        top: 5.0,
                        child: IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.grey.shade800,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            }),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Unesite email za potvrdu rezervacije:',
                          style: _customLabelStyle,
                        ),
                        const SizedBox(height: 5.0),
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white24,
                            contentPadding: const EdgeInsets.all(0),
                            focusColor: Colors.black,
                            hintText: 'Email',
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.email),
                            errorText: _isEmailValid
                                ? null
                                : 'Unesite ispravnu e-mail adresu',
                          ),
                          onChanged: (value) {
                            bool isValid = RegExp(
                                    r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                                .hasMatch(value);
                            setState(() {
                              _isEmailValid = isValid;
                              if (value == _emailKorisnika) {
                                _isEmailValid = true;
                              } else {
                                _isEmailValid = false;
                              }
                            });
                          },
                        ),
                        const SizedBox(height: 15.0),
                        Text(
                          'Odaberite frizera',
                          style: _customLabelStyle,
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 10.0,
                    indent: 20.0,
                    endIndent: 20.0,
                    thickness: 1,
                    color: Colors.grey.shade400,
                  ),
                  _uposlenici.isEmpty
                      ? Center(
                          child: Text(
                            'Nema dostupnih frizera !',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 17.0,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      : _buildListaUposlenika(setState),
                  const SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Vaša rezervacija će biti spremljena za datum ${getDateFormat(today)} u terminu ${getTimeFormat(time)} h. Ukoliko rezervacija bude uspješna bit će te obaviješteni mailom.',
                      style: _customLabelStyle,
                    ),
                  ),
                  _buildRezervacijaButton(context, time),
                  _buildOtkaziRezervaciju(context),
                  const SizedBox(height: 10.0),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  Padding _buildOtkaziRezervaciju(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
        style: ElevatedButton.styleFrom(
            elevation: 0.0,
            foregroundColor: Colors.black54,
            backgroundColor:
                const Color.fromARGB(255, 160, 41, 33).withOpacity(0.4),
            side: const BorderSide(color: Colors.black54, strokeAlign: 5.0)),
        icon: const Icon(
          Icons.cancel_outlined,
          color: Colors.black54,
        ),
        label: const Text('Odustani od rezervacije termina'),
      ),
    );
  }

  Padding _buildRezervacijaButton(BuildContext context, DateTime time) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton.icon(
        onPressed: () async {
          if (selectedUsposlenik == -1 ||
              _emailController.text == "" ||
              _isEmailValid == false) {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) => AlertDialog(
                      elevation: 0.0,
                      backgroundColor: Colors.red[300],
                      icon: const Icon(
                        Icons.error_outline,
                        size: 35,
                      ),
                      iconColor: Colors.black,
                      content: const Text(
                        'Da bi rezervacija bila uspješna morate odabrati željenog frizera i unijeti svoj email ! \nMolimo da unesete ispravano vaš email!',
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () async {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'OK',
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ));
          } else {
            var rezervacijaProvider =
                Provider.of<RezervacijaProvider>(context, listen: false);

            RezervacijaInsertRequest request = RezervacijaInsertRequest(
              today,
              time,
              true,
              Authorization.korisnikId!,
              selectedUsposlenik!,
              widget.usluga.uslugaId,
            );

            try {
              await rezervacijaProvider.insert(request);

              // ignore: use_build_context_synchronously
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: const Text('Poruka'),
                        content: const Text('Termin uspješno rezervisan.'),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();

                              await _loadTermine();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ));
            } on Exception {
              // ignore: use_build_context_synchronously
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text("Error"),
                  content: const Text("Greška prilikom rezervacije termina!"),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"))
                  ],
                ),
              );
            }
          }
        },
        style: ElevatedButton.styleFrom(
            elevation: 0.0,
            foregroundColor: Colors.black87,
            backgroundColor: Colors.grey.withOpacity(0.5),
            side: const BorderSide(color: Colors.black54, strokeAlign: 5.0)),
        icon: const Icon(
          Icons.more_time,
          color: Colors.black87,
        ),
        label: const Text('Rezerviši termin'),
      ),
    );
  }

  Expanded _buildListaUposlenika(StateSetter setState) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20.0,
            mainAxisSpacing: 20.0,
            childAspectRatio: 1,
            mainAxisExtent: 220,
          ),
          itemCount: _uposlenici.length,
          itemBuilder: (context, index) {
            Uposlenik uposlenik = _uposlenici[index];
            bool isSelected = selectedUsposlenik == uposlenik.uposlenikId;
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    selectedUsposlenik = -1;
                  } else {
                    selectedUsposlenik = uposlenik.uposlenikId;
                  }
                });
              },
              child: Card(
                color: isSelected
                    ? const Color.fromARGB(94, 128, 98, 17)
                    : const Color.fromARGB(255, 241, 231, 204),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: const Image(
                            image: AssetImage('assets/images/barber_icon.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      IgnorePointer(
                        ignoring: true,
                        child: RatingBar.builder(
                          itemSize: 20.0,
                          initialRating: uposlenik.prosjecnaOcjena,
                          minRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {},
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        '${uposlenik.ime} ${uposlenik.prezime}',
                        style: const TextStyle(
                            color: Colors.black87, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.clip,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Container _buildPrikazTermina(bool isZauzetTermin, DateTime time) {
    return Container(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: isZauzetTermin
              ? Colors.grey[900]!.withOpacity(0.4)
              : Colors.grey.withOpacity(0.3),
        ),
        borderRadius: BorderRadius.circular(8),
        color: isZauzetTermin
            ? Colors.grey[900]!.withOpacity(0.4)
            : Colors.grey.withOpacity(0.3),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          isZauzetTermin
              ? Icon(Icons.event_busy, color: Colors.grey[900], size: 24)
              : Icon(Icons.event_available, color: Colors.grey[700], size: 24),
          const SizedBox(width: 8),
          Text(
            time.toString().substring(11, 16),
            style: isZauzetTermin
                ? TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[900])
                : TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}
