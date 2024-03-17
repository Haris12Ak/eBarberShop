import 'package:ebarbershop_mobile/models/recenzije/recenzije.dart';
import 'package:ebarbershop_mobile/providers/recenzije_provider.dart';
import 'package:ebarbershop_mobile/utils/util.dart';
import 'package:ebarbershop_mobile/widgets/master_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class RecenzijeEditScreen extends StatefulWidget {
  Recenzije recenzija;
  RecenzijeEditScreen({super.key, required this.recenzija});

  @override
  State<RecenzijeEditScreen> createState() => _RecenzijeEditScreenState();
}

class _RecenzijeEditScreenState extends State<RecenzijeEditScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late RecenzijeProvider _recenzijeProvider;

  double _rating = 0.0;

  @override
  void initState() {
    super.initState();

    _initialValue = {
      'sadrzaj': widget.recenzija.sadrzaj,
      'ocjena': widget.recenzija.ocjena,
    };

    _recenzijeProvider = context.read<RecenzijeProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: 'Uredi',
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: FormBuilder(
            key: _formKey,
            initialValue: _initialValue,
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
                      initialRating: _initialValue['ocjena'],
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
                          _rating = rating;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 15.0),
                FormBuilderTextField(
                  name: 'sadrzaj',
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
                      _formKey.currentState?.saveAndValidate();

                      var request = Map.from(_formKey.currentState!.value);

                      request['datumObjave'] = DateTime.now().toIso8601String();
                      request['korisnikId'] =
                          Authorization.korisnikId!.toString();

                      if (_rating != 0.0) {
                        request['ocjena'] = _rating;
                      } else {
                        request['ocjena'] = _initialValue['ocjena'];
                      }

                      try {
                        await _recenzijeProvider.update(
                            widget.recenzija.recenzijeId, request);

                        // ignore: use_build_context_synchronously
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Poruka'),
                                  content: const Text(
                                      'Recenzija uspješno editovana !.'),
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
                                  child: const Text("OK"))
                            ],
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
                    label: const Text('Sačuvaj izmjene')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
