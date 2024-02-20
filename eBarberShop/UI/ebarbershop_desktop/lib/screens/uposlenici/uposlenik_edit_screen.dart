import 'package:ebarbershop_desktop/models/uposlenik/uposlenik.dart';
import 'package:ebarbershop_desktop/providers/uposlenik_provider.dart';
import 'package:ebarbershop_desktop/widgets/button_back_widget.dart';
import 'package:ebarbershop_desktop/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class UposlenikEditScreen extends StatefulWidget {
  Uposlenik? uposlenik;
  UposlenikEditScreen({super.key, this.uposlenik});

  @override
  State<UposlenikEditScreen> createState() => _UposlenikEditScreenState();
}

class _UposlenikEditScreenState extends State<UposlenikEditScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late UposlenikProvider _uposlenikProvider;

  @override
  void initState() {
    super.initState();
    _initialValue = {
      'uposlenikId': widget.uposlenik?.uposlenikId.toString(),
      'ime': widget.uposlenik?.ime,
      'prezime': widget.uposlenik?.prezime,
      'kontaktTelefon': widget.uposlenik?.kontaktTelefon,
      'email': widget.uposlenik?.email,
      'adresa': widget.uposlenik?.adresa,
    };

    _uposlenikProvider = context.read<UposlenikProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title:
          widget.uposlenik == null ? 'Dodaj uposlenika' : 'Detalji uposlenika',
      child: Column(
        children: [
          const ButtonBackWidget(),
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
        ],
      ),
    );
  }

  FormBuilder _buildForm(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      initialValue: _initialValue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: FormBuilderTextField(
                  name: 'ime',
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.0),
                      gapPadding: 5.0,
                    ),
                    focusColor: Colors.blue,
                    hoverColor: Colors.grey[200],
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'Ime',
                    floatingLabelStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 100.0,
              ),
              Expanded(
                child: FormBuilderTextField(
                  name: 'kontaktTelefon',
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.0),
                      gapPadding: 5.0,
                    ),
                    focusColor: Colors.blue,
                    hoverColor: Colors.grey[200],
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'Kontakt telefon',
                    floatingLabelStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          Row(
            children: [
              Expanded(
                child: FormBuilderTextField(
                  name: 'prezime',
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.0),
                      gapPadding: 5.0,
                    ),
                    focusColor: Colors.blue,
                    hoverColor: Colors.grey[200],
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'Prezime',
                    floatingLabelStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 100.0,
              ),
              Expanded(
                child: FormBuilderTextField(
                  name: 'email',
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.0),
                      gapPadding: 5.0,
                    ),
                    focusColor: Colors.blue,
                    hoverColor: Colors.grey[200],
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'Email',
                    floatingLabelStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: 855,
              child: FormBuilderTextField(
                name: 'adresa',
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0.0),
                    gapPadding: 5.0,
                  ),
                  focusColor: Colors.blue,
                  hoverColor: Colors.grey[200],
                  fillColor: Colors.white,
                  filled: true,
                  labelText: 'Adresa',
                  floatingLabelStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 50.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton.icon(
                onPressed: () async {
                  _formKey.currentState?.saveAndValidate();

                  var request = Map.from(_formKey.currentState!.value);

                  try {
                    if (widget.uposlenik != null) {
                      // ignore: use_build_context_synchronously
                      _buildEditUposlenik(context, request);
                    } else {
                      _buildAddUposlenik(context, request);
                    }
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
                icon: const Icon(Icons.save_alt),
                label: const Text(
                  'Spremi',
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
            ],
          )
        ],
      ),
    );
  }

  Future<dynamic> _buildAddUposlenik(
      BuildContext context, Map<dynamic, dynamic> request) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Potvrda!"),
        content: const Text(
            'Da li ste sigurni da želite dodati uposlenika sa unesenim informacijama!'),
        actions: [
          TextButton(
              onPressed: () async {
                if (_formKey.currentState!.saveAndValidate()) {
                  await _uposlenikProvider.insert(request);
                }
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();

                // ignore: use_build_context_synchronously
                showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: const Text('Poruka!'),
                          content: const Text(
                              'Uspješno ste dodali novog uposlenika.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                _formKey.currentState?.reset();

                                Navigator.of(context).pop();

                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ));
              },
              child: const Text("Potvrdi")),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Otkaži"))
        ],
      ),
    );
  }

  Future<dynamic> _buildEditUposlenik(
      BuildContext context, Map<dynamic, dynamic> request) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Potvrda ažuriranja podataka!"),
        content: const Text(
            'Da li ste sigurni da želite sačuvati trenutne izmjene!'),
        actions: [
          TextButton(
              onPressed: () async {
                await _uposlenikProvider.update(
                    widget.uposlenik!.uposlenikId, request);

                setState(() {
                  _initialValue = Map.from(_formKey.currentState!.value);
                });
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              },
              child: const Text("Potvrdi")),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Otkaži"))
        ],
      ),
    );
  }
}
