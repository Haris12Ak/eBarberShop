import 'package:ebarbershop_mobile/models/grad/grad.dart';
import 'package:ebarbershop_mobile/models/korisnik/korisnik.dart';
import 'package:ebarbershop_mobile/models/search_result.dart';
import 'package:ebarbershop_mobile/models/validator.dart';
import 'package:ebarbershop_mobile/providers/grad_provider.dart';
import 'package:ebarbershop_mobile/providers/korisnik_provider.dart';
import 'package:ebarbershop_mobile/screens/login_screen.dart';
import 'package:ebarbershop_mobile/utils/util.dart';
import 'package:ebarbershop_mobile/widgets/generic_form_builder_text_filed.dart';
import 'package:ebarbershop_mobile/widgets/master_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ProfilEditScreen extends StatefulWidget {
  Korisnik korisnik;

  ProfilEditScreen({super.key, required this.korisnik});

  @override
  State<ProfilEditScreen> createState() => _ProfilEditScreenState();
}

class _ProfilEditScreenState extends State<ProfilEditScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late KorisnikProvider _korisnikProvider;
  late GradProvider _gradProvider;
  SearchResult<Grad>? gradoviResult;
  bool isLoading = true;

  TextEditingController lozinkaController = TextEditingController();
  TextEditingController lozinkaPotvrdaController = TextEditingController();
  bool isLozinkaValid = true;

  bool isImeValid = true;
  bool isPrezimeValid = true;
  bool isEmailValid = true;
  bool isAdresaValid = true;
  bool isBrojTelefonaValid = true;
  bool isKorisnickoImeValid = true;

  @override
  void initState() {
    super.initState();

    _initialValue = {
      'ime': widget.korisnik.ime,
      'prezime': widget.korisnik.prezime,
      'korisnickoIme': widget.korisnik.korisnickoIme,
      'email': widget.korisnik.email,
      'adresa': widget.korisnik.adresa,
      'brojTelefona': widget.korisnik.brojTelefona,
      'status': widget.korisnik.status,
      'slika': widget.korisnik.slika,
      'gradId': widget.korisnik.gradId.toString(),
    };

    _korisnikProvider = context.read<KorisnikProvider>();
    _gradProvider = context.read<GradProvider>();

    fetchGradove();
  }

  Future fetchGradove() async {
    gradoviResult = await _gradProvider.get();

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: 'Uredi profil',
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : FormBuilder(
              key: _formKey,
              initialValue: _initialValue,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12.0),
                    GenericFormBuilderTextField(
                      name: 'ime',
                      labelText: 'ime',
                      prefixIcon: Icons.person,
                      errorText: isImeValid
                          ? null
                          : "Unesite ispravne podatke za ime.",
                      onChanged: (value) {
                        bool isValid = Validators.validirajIme(value!);
                        setState(() {
                          isImeValid = isValid;
                        });
                      },
                    ),
                    const SizedBox(height: 12.0),
                    GenericFormBuilderTextField(
                      name: 'prezime',
                      labelText: 'Prezime',
                      prefixIcon: Icons.person,
                      errorText: isPrezimeValid
                          ? null
                          : "Unesite ispravne podatke za prezime",
                      onChanged: (value) {
                        bool isValid = Validators.validirajPrezime(value!);
                        setState(() {
                          isPrezimeValid = isValid;
                        });
                      },
                    ),
                    const SizedBox(height: 12.0),
                    GenericFormBuilderTextField(
                      name: 'korisnickoIme',
                      labelText: 'Korisničko ime',
                      prefixIcon: Icons.email,
                      errorText: isKorisnickoImeValid
                          ? null
                          : "Unesite ispravno korisnicko ime.",
                      onChanged: (value) {
                        bool isValid =
                            Validators.validirajKorisnickoIme(value!);
                        setState(() {
                          isKorisnickoImeValid = isValid;
                        });
                      },
                    ),
                    const SizedBox(height: 12.0),
                    GenericFormBuilderTextField(
                      name: 'email',
                      labelText: 'Email',
                      prefixIcon: Icons.alternate_email,
                      errorText: isEmailValid ? null : "Unesite ispravno email",
                      onChanged: (value) {
                        bool isValid = Validators.validirajEmail(value!);
                        setState(() {
                          isEmailValid = isValid;
                        });
                      },
                    ),
                    const SizedBox(height: 12.0),
                    GenericFormBuilderTextField(
                      name: 'adresa',
                      labelText: 'Adresa',
                      prefixIcon: Icons.location_on,
                    ),
                    const SizedBox(height: 12.0),
                    GenericFormBuilderTextField(
                      name: 'brojTelefona',
                      labelText: 'Broj telefona',
                      prefixIcon: Icons.phone,
                      errorText: isBrojTelefonaValid
                          ? null
                          : "Unesite ispravan format broja telefona.\nExample: (06XXXXX)",
                      onChanged: (value) {
                        bool isValid = Validators.validirajBrojTelefona(value!);
                        setState(() {
                          isBrojTelefonaValid = isValid;
                        });
                      },
                    ),
                    const SizedBox(height: 12.0),
                    FormBuilderDropdown<String>(
                      name: 'gradId',
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10.0),
                        border: const OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white30,
                        labelText: 'Mjesto boravka',
                        prefixIcon: const Icon(Icons.location_city),
                        floatingLabelStyle: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500),
                      ),
                      items: gradoviResult?.result
                              .map(
                                (item) => DropdownMenuItem(
                                  alignment: AlignmentDirectional.centerStart,
                                  value: item.gradId.toString(),
                                  child: Text(item.naziv),
                                ),
                              )
                              .toList() ??
                          [],
                    ),
                    const SizedBox(height: 25.0),
                    const Text(
                      'Promjena lozinke je opcinalno',
                      style: TextStyle(fontSize: 15.0, color: Colors.black),
                    ),
                    const SizedBox(height: 8.0),
                    TextField(
                      controller: lozinkaController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10.0),
                        border: const OutlineInputBorder(),
                        focusedBorder: const OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white30,
                        hintText: 'Lozinka',
                        errorText: isLozinkaValid
                            ? null
                            : 'Lozinka mora sadržavati minimalno 4 znaka!',
                      ),
                      onChanged: (value) {
                        setState(() {
                          if (value.length >= 4 && value.isNotEmpty) {
                            isLozinkaValid = true;
                          } else {
                            isLozinkaValid = false;
                          }
                        });
                      },
                    ),
                    const SizedBox(height: 12.0),
                    TextField(
                      controller: lozinkaPotvrdaController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10.0),
                        border: const OutlineInputBorder(),
                        focusedBorder: const OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white30,
                        hintText: 'Lozinka potvrda',
                        errorText:
                            isLozinkaValid ? null : 'Lozinke se ne podudaraju!',
                      ),
                      onChanged: (value) {
                        setState(() {
                          if (lozinkaController.text.isNotEmpty &&
                              value.isNotEmpty &&
                              lozinkaController.text == value) {
                            isLozinkaValid = true;
                          } else {
                            isLozinkaValid = false;
                          }
                        });
                      },
                    ),
                    const SizedBox(height: 25.0),
                    _buildSaveChanges(context),
                  ],
                ),
              ),
            ),
    );
  }

  ElevatedButton _buildSaveChanges(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: isImeValid &&
                isPrezimeValid &&
                isEmailValid &&
                isBrojTelefonaValid &&
                isKorisnickoImeValid &&
                isLozinkaValid
            ? () async {
                _formKey.currentState?.saveAndValidate();

                var request = Map.from(_formKey.currentState!.value);

                request['slika'] = widget.korisnik.slika.toString();

                request['lozinka'] = lozinkaController.text;
                request['lozinkaPotvrda'] = lozinkaController.text;

                try {
                  await _korisnikProvider.update(
                      widget.korisnik.korisniciId, request);

                  setState(() {
                    _initialValue = Map.from(_formKey.currentState!.value);
                  });

                  Authorization.email = _initialValue['email'];

                  if (lozinkaController.text != "" ||
                      _initialValue['korisnickoIme'] !=
                          widget.korisnik.korisnickoIme) {
                    // ignore: use_build_context_synchronously
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) => AlertDialog(
                              title: const Text('Obavijest'),
                              content: const Text(
                                  'Promijenili ste lozinku ili korisničko ime. Molimo vas da se ponovo prijavite.'),
                              actions: [
                                TextButton(
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => const LoginScreen()),
                                      (route) => false,
                                    );
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ));
                  } else {
                    // ignore: use_build_context_synchronously
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) => AlertDialog(
                              title: const Text('Poruka'),
                              content:
                                  const Text('Profil uspješno izmjenjen !.'),
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
              }
            : null,
        style: ElevatedButton.styleFrom(
          elevation: 1.0,
          backgroundColor: Colors.blue.withOpacity(.5),
          foregroundColor: Colors.white,
        ),
        icon: const Icon(Icons.save_alt),
        label: const Text('Sačuvaj izmjene'));
  }
}
