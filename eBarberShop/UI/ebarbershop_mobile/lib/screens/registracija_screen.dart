import 'package:ebarbershop_mobile/models/grad/grad.dart';
import 'package:ebarbershop_mobile/models/korisnik/korisnik_insert_request.dart';
import 'package:ebarbershop_mobile/models/search_result.dart';
import 'package:ebarbershop_mobile/models/validator.dart';
import 'package:ebarbershop_mobile/providers/grad_provider.dart';
import 'package:ebarbershop_mobile/providers/korisnik_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistracijaScreen extends StatefulWidget {
  const RegistracijaScreen({super.key});

  @override
  State<RegistracijaScreen> createState() => _RegistracijaScreenState();
}

class _RegistracijaScreenState extends State<RegistracijaScreen> {
  SearchResult<Grad>? gradovi;
  late GradProvider _gradProvider;
  bool isLoading = true;

  final TextEditingController _imeController = TextEditingController();
  final TextEditingController _prezimeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _adresaController = TextEditingController();
  final TextEditingController _brojTelefonaController = TextEditingController();
  final TextEditingController _korisnickoImeController =
      TextEditingController();
  final TextEditingController _lozinkaController = TextEditingController();
  final TextEditingController _lozinkaPotvrdaController =
      TextEditingController();
  String? selectedGradNaziv;
  int? selectedGradId;
  bool status = true;

  bool isImeValid = true;
  bool isPrezimeValid = true;
  bool isEmailValid = true;
  bool isAdresaValid = true;
  bool isBrojTelefonaValid = true;
  bool isKorisnickoImeValid = true;
  bool isMjestoBoravkaValid = false;
  bool isLozinkaValid = true;
  bool isLozinkaPotvrdaValid = true;

  @override
  void initState() {
    super.initState();

    _gradProvider = context.read<GradProvider>();

    fetchGradove();
  }

  Future fetchGradove() async {
    gradovi = await _gradProvider.get();

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Registracija'),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Unseite lične podatke',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                        controller: _imeController,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10.0),
                            border: const OutlineInputBorder(),
                            focusedBorder: const OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white30,
                            labelText: 'Ime',
                            prefixIcon: const Icon(Icons.person),
                            floatingLabelStyle: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500),
                            errorText: isImeValid
                                ? null
                                : "Unesite ispravne podatke za ime"),
                        onChanged: (value) {
                          bool isValid = Validators.validirajIme(value);
                          setState(() {
                            isImeValid = isValid;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                        controller: _prezimeController,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10.0),
                            border: const OutlineInputBorder(),
                            focusedBorder: const OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white30,
                            labelText: 'Prezime',
                            prefixIcon: const Icon(Icons.person),
                            floatingLabelStyle: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500),
                            errorText: isPrezimeValid
                                ? null
                                : "Unesite ispravne podatke za prezime"),
                        onChanged: (value) {
                          bool isValid = Validators.validirajPrezime(value);
                          setState(() {
                            isPrezimeValid = isValid;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10.0),
                            border: const OutlineInputBorder(),
                            focusedBorder: const OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white30,
                            labelText: 'Email',
                            prefixIcon: const Icon(Icons.alternate_email),
                            floatingLabelStyle: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500),
                            errorText:
                                isEmailValid ? null : "Unesite ispravno email"),
                        onChanged: (value) {
                          bool isValid = Validators.validirajEmail(value);
                          setState(() {
                            isEmailValid = isValid;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                        controller: _adresaController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10.0),
                          border: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white30,
                          labelText: 'Adresa (opcionalno)',
                          prefixIcon: const Icon(Icons.location_on),
                          floatingLabelStyle: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                        controller: _brojTelefonaController,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10.0),
                            border: const OutlineInputBorder(),
                            focusedBorder: const OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white30,
                            labelText: 'Broj telefona (opcionalno)',
                            prefixIcon: const Icon(Icons.phone),
                            floatingLabelStyle: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500),
                            errorText: isBrojTelefonaValid
                                ? null
                                : "Unesite ispravan format broja telefona.\nExample: (06XXXXX)"),
                        onChanged: (value) {
                          bool isValid =
                              Validators.validirajBrojTelefona(value);
                          setState(() {
                            isBrojTelefonaValid = isValid;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: DropdownButton(
                          value: selectedGradNaziv,
                          items: gradovi?.result
                                  .map(
                                    (item) => DropdownMenuItem(
                                      alignment:
                                          AlignmentDirectional.centerStart,
                                      value: item.gradId.toString(),
                                      child: Text(item.naziv),
                                    ),
                                  )
                                  .toList() ??
                              [],
                          onChanged: (value) {
                            setState(() {
                              selectedGradNaziv = value as String?;
                            });

                            final odabraniGrad = gradovi?.result.firstWhere(
                                (grad) => grad.gradId.toString() == value);

                            setState(() {
                              selectedGradId = odabraniGrad!.gradId;
                            });
                          },
                          isExpanded: true,
                          hint: const Text('Mjesto boravka'),
                          icon: const Icon(Icons.location_city),
                        ),
                      ),
                      const Divider(
                        height: 40.0,
                      ),
                      TextField(
                        controller: _korisnickoImeController,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10.0),
                            border: const OutlineInputBorder(),
                            focusedBorder: const OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white30,
                            labelText: 'Korisničko ime',
                            prefixIcon: const Icon(Icons.email),
                            floatingLabelStyle: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500),
                            errorText: isKorisnickoImeValid
                                ? null
                                : "Unesite ispravno korisnicko ime."),
                        onChanged: (value) {
                          bool isValid =
                              Validators.validirajKorisnickoIme(value);
                          setState(() {
                            isKorisnickoImeValid = isValid;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                        controller: _lozinkaController,
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10.0),
                          border: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white30,
                          labelText: 'Lozinka',
                          prefixIcon: const Icon(Icons.password),
                          floatingLabelStyle: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500),
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
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                        controller: _lozinkaPotvrdaController,
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10.0),
                          border: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white30,
                          labelText: 'Lozinka potvrda',
                          prefixIcon: const Icon(Icons.password),
                          floatingLabelStyle: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500),
                          errorText: isLozinkaValid
                              ? null
                              : 'Lozinke se ne podudaraju!',
                        ),
                        onChanged: (value) {
                          setState(() {
                            if (_lozinkaController.text.isNotEmpty &&
                                _lozinkaController.text == value) {
                              isLozinkaValid = true;
                            } else {
                              isLozinkaValid = false;
                            }
                          });
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      IgnorePointer(
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Status',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54),
                              ),
                              const SizedBox(height: 5.0),
                              Switch(
                                value: status,
                                onChanged: (newValue) {
                                  setState(() {
                                    status = newValue;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      _buildSaveButton(context),
                    ],
                  ),
                ),
              ));
  }

  ElevatedButton _buildSaveButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: _imeController.text != "" &&
              _prezimeController.text != "" &&
              _emailController.text != "" &&
              _korisnickoImeController.text != "" &&
              _lozinkaController.text != "" &&
              _lozinkaPotvrdaController.text != "" &&
              selectedGradNaziv != null &&
              isPrezimeValid &&
              isEmailValid &&
              isBrojTelefonaValid &&
              isKorisnickoImeValid &&
              isLozinkaValid &&
              isLozinkaPotvrdaValid &&
              isImeValid
          ? () async {
              var korisnikProvider =
                  Provider.of<KorisnikProvider>(context, listen: false);

              KorisnikInsertRequest request = KorisnikInsertRequest(
                  _imeController.text,
                  _prezimeController.text,
                  _emailController.text,
                  _adresaController.text,
                  _brojTelefonaController.text,
                  _korisnickoImeController.text,
                  _lozinkaController.text,
                  _lozinkaPotvrdaController.text,
                  status,
                  null,
                  selectedGradId!);

              try {
                await korisnikProvider.insert(request);

                // ignore: use_build_context_synchronously
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: const Text('Registracija uspješna !'),
                          content: const Text(
                              'Vaš korisnički račun je aktiviran i možete se prijaviti na našu platformu koristeći svoje pristupne podatke'),
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
              } on Exception {
                // ignore: use_build_context_synchronously
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text("Greška"),
                    content: const Text("Korisnicko ime vec postoji!\nMolimo da unesete drugo korisničko ime."),
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
          elevation: 5.0,
          backgroundColor: Colors.blue.shade200,
          foregroundColor: Colors.black),
      label: const Text(
        'Spremi',
        style: TextStyle(fontSize: 16),
      ),
      icon: const Icon(
        Icons.save_alt,
        size: 26,
      ),
    );
  }
}
