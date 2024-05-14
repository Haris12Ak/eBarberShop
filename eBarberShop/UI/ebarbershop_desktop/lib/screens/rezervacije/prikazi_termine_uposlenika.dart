import 'package:ebarbershop_desktop/models/rezervacije/rezervacija.dart';
import 'package:ebarbershop_desktop/models/search_result.dart';
import 'package:ebarbershop_desktop/providers/rezervacija_provider.dart';
import 'package:ebarbershop_desktop/utils/util.dart';
import 'package:ebarbershop_desktop/widgets/master_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class PrikaziTermineUposlenika extends StatefulWidget {
  String imePrezimeUposlenika;
  DateTime datum;
  PrikaziTermineUposlenika(
      {super.key, required this.imePrezimeUposlenika, required this.datum});

  @override
  State<PrikaziTermineUposlenika> createState() =>
      _PrikaziTermineUposlenikaState();
}

class _PrikaziTermineUposlenikaState extends State<PrikaziTermineUposlenika> {
  late RezervacijaProvider _rezervacijaProvider;
  SearchResult<Rezervacija>? terminiUposlenikaResult;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    _rezervacijaProvider = context.read<RezervacijaProvider>();

    fetchRezervacijeUposlenika();
  }

  Future fetchRezervacijeUposlenika() async {
    terminiUposlenikaResult = await _rezervacijaProvider.get(filter: {
      'ImePrezimeUposlenika': widget.imePrezimeUposlenika,
      'Datum': widget.datum,
      'IsKorisnikIncluded': true,
      'IsUslugaIncluded': true
    });

    terminiUposlenikaResult!.result
        .sort((a, b) => a.vrijeme.compareTo(b.vrijeme));

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: 'Termini',
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Pregled termina za uposlenika ${widget.imePrezimeUposlenika}',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  'Datum: ${getDateFormat(widget.datum)}',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                SingleChildScrollView(
                  child: ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 20.0),
                    itemCount: terminiUposlenikaResult!.result.length,
                    itemBuilder: (BuildContext context, int index) {
                      Rezervacija rezervacija =
                          terminiUposlenikaResult!.result[index];
                      return Container(
                        color: Colors.grey.shade100,
                        child: ListTile(
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: 'Klijent: ',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.grey.shade900,
                                          fontWeight: FontWeight.w500)),
                                  TextSpan(
                                      text:
                                          '${rezervacija.klijentIme ?? ""} ${rezervacija.klijentPrezime ?? ""}',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.grey.shade700,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                          ),
                          subtitle: Row(
                            children: [
                              Expanded(
                                flex: 1,
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
                              const SizedBox(width: 20.0, child: Text('|')),
                              Expanded(
                                flex: 2,
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
                                          text: getTimeFormat(
                                              rezervacija.vrijeme),
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.grey.shade700,
                                              fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          trailing: IconButton(
                              tooltip: 'Ukloni termin',
                              onPressed: () {
                                try {
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text('Potvrda'),
                                      content: Text(
                                          'Jeste li sigurni da želite ukloniti termin klijenta ${rezervacija.klijentIme} ${rezervacija.klijentPrezime}, \nkreiran datuma: ${getDateFormat(rezervacija.datum)} u terminu od ${getTimeFormat(rezervacija.vrijeme)}, \nkod frizera ${widget.imePrezimeUposlenika} !'),
                                      actions: [
                                        TextButton(
                                          onPressed: () async {
                                            await _rezervacijaProvider
                                                .delete(
                                                    rezervacija.rezervacijaId)
                                                .then((value) =>
                                                    Navigator.of(context)
                                                        .pop());

                                            if (!context.mounted) {
                                              return;
                                            }

                                            fetchRezervacijeUposlenika();
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
                                  Navigator.of(context).pop();

                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text("Error"),
                                      content: Text(e.toString()),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text("Close"),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              },
                              icon: const Icon(Icons.delete_forever)),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    'Ukupno termina: ${terminiUposlenikaResult!.count}',
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
}
