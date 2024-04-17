import 'package:ebarbershop_mobile/models/ocjene/ocjene.dart';
import 'package:ebarbershop_mobile/models/ocjene/ocjene_insert_request.dart';
import 'package:ebarbershop_mobile/models/search_result.dart';
import 'package:ebarbershop_mobile/models/uposlenik/uposlenik.dart';
import 'package:ebarbershop_mobile/providers/ocjene_provider.dart';
import 'package:ebarbershop_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class UposlenikInfoScreen extends StatefulWidget {
  Uposlenik uposlenik;
  UposlenikInfoScreen({super.key, required this.uposlenik});

  @override
  State<UposlenikInfoScreen> createState() => _UposlenikInfoScreenState();
}

class _UposlenikInfoScreenState extends State<UposlenikInfoScreen> {
  late OcjeneProvider _ocjeneProvider;
  SearchResult<Ocjene>? ocjeneResult;
  bool isLoading = true;

  final TextEditingController _opis = TextEditingController();
  double _raiting = 1.0;

  double prosjecnaOcjenaUposlenika(List<Ocjene> ocjene) {
    if (ocjene.isEmpty) {
      return 0.0;
    }

    double total = 0.0;
    for (var ocjena in ocjene) {
      total += ocjena.ocjena;
    }

    return total / ocjene.length;
  }

  @override
  void initState() {
    super.initState();

    _ocjeneProvider = context.read<OcjeneProvider>();
    fetchOcjene();
  }

  Future fetchOcjene() async {
    ocjeneResult =
        await _ocjeneProvider.GetOcjene(widget.uposlenik.uposlenikId);

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  static const TextStyle _labelStyle = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.black87);

  static const TextStyle _contentStyle = TextStyle(
      fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.black54);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(241, 231, 204, 0.9),
        elevation: 0.0,
        title: const Text(
          'Informacije frizera',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.0,
            fontSize: 20,
          ),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 250,
                  padding: const EdgeInsets.symmetric(
                      vertical: 45.0, horizontal: 120.0),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.elliptical(80, 40),
                      bottomRight: Radius.elliptical(80, 40),
                    ),
                    color: const Color.fromRGBO(241, 231, 204, 0.9),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: const Image(
                      image: AssetImage('assets/images/barber_icon.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Ime:',
                            style: _labelStyle,
                          ),
                          Text(
                            widget.uposlenik.ime,
                            style: _contentStyle,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          const Text(
                            'Prezime:',
                            style: _labelStyle,
                          ),
                          Text(
                            widget.uposlenik.prezime,
                            style: _contentStyle,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          const Text(
                            'Email:',
                            style: _labelStyle,
                          ),
                          Text(
                            widget.uposlenik.email ?? "",
                            style: _contentStyle,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          const Text(
                            'Kontakt telefon:',
                            style: _labelStyle,
                          ),
                          Text(
                            widget.uposlenik.kontaktTelefon,
                            style: _contentStyle,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          const Text(
                            'Adresa:',
                            style: _labelStyle,
                          ),
                          Text(
                            widget.uposlenik.adresa ?? "",
                            style: _contentStyle,
                          ),
                          const SizedBox(height: 10.0),
                          const Text(
                            'Prosječna ocjena:',
                            style: _labelStyle,
                          ),
                          const SizedBox(
                            height: 2.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IgnorePointer(
                                ignoring: true,
                                child: RatingBar.builder(
                                  itemSize: 25.0,
                                  initialRating: prosjecnaOcjenaUposlenika(
                                      ocjeneResult!.result),
                                  minRating: 0,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 2.0),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {},
                                ),
                              ),
                              Text(
                                formatNumber(prosjecnaOcjenaUposlenika(
                                    ocjeneResult!.result)),
                                style: _contentStyle,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10.0),
                          _buildPrikaziOcjene(context),
                          const Divider(
                            height: 40.0,
                            color: Colors.black26,
                            thickness: 2,
                          ),
                          const Text(
                            'Ocjeni frizera:',
                            style: _labelStyle,
                          ),
                          const SizedBox(height: 2.0),
                          RatingBar.builder(
                            itemSize: 25.0,
                            initialRating: 1,
                            minRating: 0,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 2.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              setState(() {
                                _raiting = rating;
                              });
                            },
                          ),
                          const SizedBox(height: 10.0),
                          const Text(
                            'Opis (opcionalno):',
                            style: _labelStyle,
                          ),
                          const SizedBox(height: 2.0),
                          TextField(
                            controller: _opis,
                            minLines: 2,
                            maxLines: null,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white24,
                              contentPadding: EdgeInsets.all(10.0),
                              focusColor: Colors.black,
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {},
                          ),
                          const SizedBox(height: 10.0),
                          _buildOcjeniUposlenika(context),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  ElevatedButton _buildOcjeniUposlenika(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        DateTime today = DateTime.now();

        OcjeneInsertRequest request = OcjeneInsertRequest(
            today,
            _raiting,
            _opis.text,
            widget.uposlenik.uposlenikId,
            Authorization.korisnikId!);

        try {
          await _ocjeneProvider.insert(request);

          // ignore: use_build_context_synchronously
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) => AlertDialog(
                    title: const Text('Poruka'),
                    content: const Text('Ocjena uspješno dodana!.'),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          Navigator.of(context).pop();
                          setState(() {
                            _opis.text = "";
                            _raiting = 0.0;
                            fetchOcjene();
                          });
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ));
        } catch (e) {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              showCloseIcon: true,
              content: Text("Moguće je dodati ocjenu samo jednom."),
            ),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        alignment: Alignment.center,
        elevation: 0.0,
        foregroundColor: Colors.black87,
        backgroundColor: Colors.blue.shade200,
        textStyle: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
      ),
      icon: const Icon(Icons.save_alt),
      label: const Text('Spremi'),
    );
  }

  ElevatedButton _buildPrikaziOcjene(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        showModalBottomSheet(
            useSafeArea: true,
            showDragHandle: true,
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 500,
                padding: const EdgeInsets.all(10.0),
                width: double.infinity,
                child: ocjeneResult!.result.isEmpty
                    ? const Center(
                        child: Text(
                          'Nema ocjena !',
                          style: _contentStyle,
                        ),
                      )
                    : ListView.separated(
                        itemCount: ocjeneResult!.result.length,
                        itemBuilder: (BuildContext context, int index) {
                          Ocjene ocjena = ocjeneResult!.result[index];
                          return ListTile(
                            isThreeLine: true,
                            trailing: Text(
                              formatNumber(ocjena.ocjena),
                              style: _contentStyle,
                            ),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IgnorePointer(
                                  ignoring: true,
                                  child: RatingBar.builder(
                                    itemSize: 20.0,
                                    initialRating: ocjena.ocjena,
                                    minRating: 0,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 0.0),
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {},
                                  ),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Text(ocjena.opis ?? ""),
                              ],
                            ),
                            leading: const Icon(Icons.comment_outlined),
                            title: Text(ocjena.korisnickoIme ?? ""),
                          );
                        },
                        separatorBuilder: (context, index) => Divider(
                          height: 20.0,
                          color: Colors.grey.shade400,
                        ),
                      ),
              );
            });
      },
      style: ElevatedButton.styleFrom(
        alignment: Alignment.center,
        elevation: 0.0,
        foregroundColor: Colors.black54,
        backgroundColor: Colors.black12,
        textStyle: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
      ),
      icon: const Icon(Icons.star),
      label: const Text('Prikaži ocjene'),
    );
  }
}
