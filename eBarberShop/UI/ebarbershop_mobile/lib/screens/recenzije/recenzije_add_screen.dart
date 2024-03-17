import 'package:ebarbershop_mobile/models/recenzije/recenzije_insert_request.dart';
import 'package:ebarbershop_mobile/providers/recenzije_provider.dart';
import 'package:ebarbershop_mobile/utils/util.dart';
import 'package:ebarbershop_mobile/widgets/master_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class RecenzijeAddScreen extends StatefulWidget {
  const RecenzijeAddScreen({super.key});

  @override
  State<RecenzijeAddScreen> createState() => _RecenzijeAddScreenState();
}

class _RecenzijeAddScreenState extends State<RecenzijeAddScreen> {
  final TextEditingController _sadrzaj = TextEditingController();
  double _raiting = 0.0;

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
        title: 'Dodaj recenziju',
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Ocjena:',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    RatingBar.builder(
                      itemSize: 35.0,
                      initialRating: 1,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 5.0),
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
                  ],
                ),
                const SizedBox(height: 15.0),
                TextFormField(
                  controller: _sadrzaj,
                  minLines: 15,
                  maxLines: null,
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Napišite svoju recenziju...',
                      border: OutlineInputBorder()),
                ),
                const SizedBox(height: 15.0),
                ElevatedButton.icon(
                    onPressed: () async {
                      var recenzijeProvider = Provider.of<RecenzijeProvider>(
                          context,
                          listen: false);

                      var dateTime = DateTime.now();

                      RecenzijeInsertRequest request = RecenzijeInsertRequest(
                        _sadrzaj.text,
                        _raiting,
                        dateTime,
                        Authorization.korisnikId!,
                      );

                      try {
                        await recenzijeProvider.insert(request);

                        // ignore: use_build_context_synchronously
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Poruka'),
                                  content:
                                      const Text('Recenzija uspješno dodana!.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ));
                      } catch (e) {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text("Moguće je dodati recenziju samo jednom."),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 1.0,
                      backgroundColor: Colors.blue.withOpacity(.5),
                      foregroundColor: Colors.white,
                    ),
                    icon: const Icon(Icons.save_alt),
                    label: const Text('Spremi')),
              ],
            ),
          ),
        ));
  }
}
