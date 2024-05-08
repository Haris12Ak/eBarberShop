import 'package:ebarbershop_desktop/models/uposlenik/uposlenik.dart';
import 'package:ebarbershop_desktop/models/validator.dart';
import 'package:ebarbershop_desktop/providers/uposlenik_provider.dart';
import 'package:ebarbershop_desktop/utils/util.dart';
import 'package:ebarbershop_desktop/widgets/master_screen_widget.dart';
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

  bool isImeValid = true;

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
    return MasterScreenWidget(
      title:
          widget.uposlenik == null ? 'Dodaj uposlenika' : 'Detalji uposlenika',
      child: FormBuilder(
        key: _formKey,
        initialValue: _initialValue,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    flex: 1,
                    child: Text(
                      'Ime:',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54),
                    ),
                  ),
                  const SizedBox(width: 30.0),
                  Expanded(
                    flex: 3,
                    child: FormBuilderTextField(
                      name: 'ime',
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        hintText: 'Ime',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Obavezno polje';
                        }
                        if (!Validators.validirajIme(value)) {
                          return 'Unseite ispravno podatke za ime';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    flex: 1,
                    child: Text(
                      'Prezime:',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54),
                    ),
                  ),
                  const SizedBox(width: 30.0),
                  Expanded(
                    flex: 3,
                    child: FormBuilderTextField(
                      name: 'prezime',
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          hintText: 'Prezime'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Obavezno polje';
                        }
                        if (!Validators.validirajPrezime(value)) {
                          return 'Unseite ispravno podatke za prezime';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    flex: 1,
                    child: Text(
                      'Kontakt telefon:',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54),
                    ),
                  ),
                  const SizedBox(width: 30.0),
                  Expanded(
                    flex: 3,
                    child: FormBuilderTextField(
                      name: 'kontaktTelefon',
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          hintText: 'Kontakt telefon'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Obavezno polje';
                        }
                        if (!Validators.validirajBrojTelefona(value)) {
                          return 'Unesite ispravan format broja telefona.\nExample: (06XXXXX)';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    flex: 1,
                    child: Text(
                      'Email:',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54),
                    ),
                  ),
                  const SizedBox(width: 30.0),
                  Expanded(
                    flex: 3,
                    child: FormBuilderTextField(
                      name: 'email',
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          hintText: 'Email (opcionalno)'),
                      validator: (value) {
                        if (value != null && value.isNotEmpty) {
                          if (!Validators.validirajEmail(value)) {
                            return 'Unesite ispravno email';
                          }
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    flex: 1,
                    child: Text(
                      'Adresa:',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54),
                    ),
                  ),
                  const SizedBox(width: 30.0),
                  Expanded(
                    flex: 3,
                    child: FormBuilderTextField(
                      name: 'adresa',
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          hintText: 'Adresa (opcionalno)'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30.0),
              if (widget.uposlenik != null)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      flex: 1,
                      child: Text(
                        'Prosječna ocjena:',
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54),
                      ),
                    ),
                    const SizedBox(width: 30.0),
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 28.0,
                          ),
                          const SizedBox(width: 10.0),
                          Text(
                            formatNumber(widget.uposlenik!.prosjecnaOcjena),
                            style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 30.0),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    if (_formKey.currentState!.saveAndValidate()) {
                      var request = Map.from(_formKey.currentState!.value);

                      if (widget.uposlenik != null) {
                        _buildEditUposlenika(context, request);
                      } else {
                        _buildAddUposlenik(context, request);
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          showCloseIcon: true,
                          content: Text("Unesite ispravno podatke !."),
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
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _buildAddUposlenik(
      BuildContext context, Map<dynamic, dynamic> request) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Potvrda!"),
        content: const Text(
            'Da li ste sigurni da želite dodati uposlenika sa unesenim informacijama!'),
        actions: [
          TextButton(
              onPressed: () async {
                try {
                  Navigator.of(context).pop();

                  if (_formKey.currentState!.saveAndValidate()) {
                    await _uposlenikProvider.insert(request);
                  }

                  // ignore: use_build_context_synchronously
                  showDialog(
                      barrierDismissible: false,
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
                } on Exception catch (e) {
                  // ignore: use_build_context_synchronously
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
                          child: const Text("OK"),
                        ),
                      ],
                    ),
                  );
                }
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

  Future<dynamic> _buildEditUposlenika(
      BuildContext context, Map<dynamic, dynamic> request) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Potvrda ažuriranja podataka!"),
        content: const Text(
            'Da li ste sigurni da želite sačuvati trenutne izmjene!'),
        actions: [
          TextButton(
              onPressed: () async {
                try {
                  Navigator.of(context).pop();

                  await _uposlenikProvider.update(
                      widget.uposlenik!.uposlenikId, request);

                  // ignore: use_build_context_synchronously
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            title: const Text('Poruka!'),
                            content: const Text('Uposlenik uspješno editovan.'),
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
                } on Exception catch (e) {
                  // ignore: use_build_context_synchronously
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
                          child: const Text("OK"),
                        ),
                      ],
                    ),
                  );
                }
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
