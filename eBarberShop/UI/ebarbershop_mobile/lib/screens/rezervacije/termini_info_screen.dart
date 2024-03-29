import 'package:ebarbershop_mobile/models/rezervacija/termini_korisnika_info.dart';
import 'package:ebarbershop_mobile/models/search_result.dart';
import 'package:ebarbershop_mobile/providers/rezervacija_provider.dart';
import 'package:ebarbershop_mobile/utils/util.dart';
import 'package:ebarbershop_mobile/widgets/master_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TerminiInfroScreen extends StatefulWidget {
  const TerminiInfroScreen({super.key});

  @override
  State<TerminiInfroScreen> createState() => _TerminiInfroScreenState();
}

class _TerminiInfroScreenState extends State<TerminiInfroScreen> {
  late RezervacijaProvider _rezervacijaProvider;
  SearchResult<TerminiKorisnikaInfo>? terminiKorisnikaResult;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    _rezervacijaProvider = context.read<RezervacijaProvider>();
    fetchTerminiByKorisnik();
  }

  Future fetchTerminiByKorisnik() async {
    terminiKorisnikaResult = await _rezervacijaProvider.GetTermineByKorisnikId(
        Authorization.korisnikId!);

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  int calculateActiveAppointment(List<TerminiKorisnikaInfo> termini) {
    if (termini.isEmpty) {
      return 0;
    }

    int total = 0;
    for (var termin in termini) {
      if (termin.isAktivna) {
        total += 1;
      }
    }

    return total;
  }

  int calculateNotActiveAppointment(List<TerminiKorisnikaInfo> termini) {
    if (termini.isEmpty) {
      return 0;
    }

    int total = 0;
    for (var termin in termini) {
      if (!termin.isAktivna) {
        total += 1;
      }
    }

    return total;
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: 'Historija termina',
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : terminiKorisnikaResult!.result.isEmpty
              ? Center(
                  child: Text(
                    'Historija termina prazna !',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 17.0,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w600),
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: terminiKorisnikaResult!.result.length,
                          itemBuilder: _buildListaTermina),
                    ),
                    Divider(
                      height: 20.0,
                      color: Colors.grey.shade400,
                      thickness: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Ukupno: ${terminiKorisnikaResult!.count}',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade800),
                        ),
                        Text(
                          'Aktivni: ${calculateActiveAppointment(terminiKorisnikaResult!.result)}',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.green.shade400.withOpacity(.8)),
                        ),
                        Text(
                          'Neaktivni: ${calculateNotActiveAppointment(terminiKorisnikaResult!.result)}',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.red.shade400.withOpacity(.8)),
                        ),
                      ],
                    ),
                  ],
                ),
    );
  }

  Widget? _buildListaTermina(BuildContext context, int index) {
    TerminiKorisnikaInfo termin = terminiKorisnikaResult!.result[index];
    return Container(
      decoration: BoxDecoration(
        color: termin.isAktivna
            ? Colors.green.shade100.withOpacity(.5)
            : Colors.red.shade100.withOpacity(.5),
      ),
      margin: const EdgeInsets.only(bottom: 8.0, top: 5.0),
      padding: const EdgeInsets.all(5.0),
      child: ListTile(
        leading: termin.isAktivna
            ? Icon(
                Icons.check,
                size: 28.0,
                color: Colors.green.shade800.withOpacity(.7),
              )
            : Icon(
                Icons.close,
                size: 28.0,
                color: Colors.red.shade800.withOpacity(.7),
              ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              getDateFormat(termin.datum),
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            const Text(
              '|',
              style: TextStyle(fontSize: 24.0),
            ),
            Text(
              getTimeFormat(termin.vrijeme),
              style: const TextStyle(fontWeight: FontWeight.w500),
            )
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 5.0,
            ),
            Text('Usluga: ${termin.nazivUsluge}'),
            const SizedBox(
              height: 5.0,
            ),
            termin.isAktivna
                ? const Text('Status: Aktivna')
                : const Text('Status Neaktivna')
          ],
        ),
        trailing: _buildRemoveFromHistory(context, termin),
      ),
    );
  }

  GestureDetector _buildRemoveFromHistory(
      BuildContext context, TerminiKorisnikaInfo termin) {
    return GestureDetector(
      onTap: () async {
        try {
          // ignore: use_build_context_synchronously
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Potvrda'),
              content: Text(
                  'Jeste li sigurni da želite ukloniti rezervaciju datuma: ${getDateFormat(termin.datum)} u terminu ${getTimeFormat(termin.vrijeme)} h, iz historije pregleda termina !'),
              actions: [
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();

                    await _rezervacijaProvider.delete(termin.rezervacijaId);

                    await fetchTerminiByKorisnik();
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
      child: const Icon(
        Icons.delete_forever,
        size: 26.0,
      ),
    );
  }
}
