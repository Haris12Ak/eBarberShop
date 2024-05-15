import 'package:ebarbershop_mobile/models/korisnik/korisnik.dart';
import 'package:ebarbershop_mobile/providers/login_provider.dart';
import 'package:ebarbershop_mobile/screens/home_screen.dart';
import 'package:ebarbershop_mobile/screens/registracija_screen.dart';
import 'package:ebarbershop_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscured = true;
  IconData _icon = Icons.visibility_off;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late LoginProvider _loginProvider;
  Korisnik? korisnikResponse;

  @override
  void initState() {
    super.initState();

    _loginProvider = context.read<LoginProvider>();
  }

  Future<void> getData() async {
    korisnikResponse = await _loginProvider.login();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blue.shade300,
            Colors.blue.shade100,
            Colors.white,
            Colors.blue.shade50,
            Colors.blue.shade200,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Prijava',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          letterSpacing: 1.0,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    ),
                  ),
                  const SizedBox(
                    height: 80.0,
                  ),
                  Image.asset(
                    'assets/images/barber_shop.png',
                    height: 150.0,
                    width: 150.0,
                  ),
                  const SizedBox(height: 50.0),
                  Container(
                    color: Colors.white38,
                    child: TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        floatingLabelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500),
                        labelStyle: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.w400),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                        focusColor: Colors.black,
                        labelText: 'Korisničko ime',
                        prefixIcon: Icon(
                          Icons.email,
                        ),
                        contentPadding: EdgeInsets.all(15.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Container(
                    color: Colors.white38,
                    child: TextField(
                      controller: _passwordController,
                      obscureText: _isObscured,
                      decoration: InputDecoration(
                        floatingLabelStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500),
                        labelStyle: const TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.w400),
                        labelText: 'Lozinka',
                        suffixIcon: IconButton(
                          icon: Icon(_icon),
                          onPressed: () {
                            setState(() {
                              _isObscured = !_isObscured;
                              _icon = _isObscured
                                  ? Icons.visibility_off
                                  : Icons.visibility;
                            });
                          },
                        ),
                        border: const OutlineInputBorder(),
                        focusedBorder: const OutlineInputBorder(),
                        focusColor: Colors.black,
                        prefixIcon: const Icon(Icons.password),
                        contentPadding: const EdgeInsets.all(15.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  _buildLogin(context),
                  const SizedBox(height: 10.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const RegistracijaScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 0.0, backgroundColor: Colors.transparent),
                    child: const Text(
                      'Nemate račun? Registruj se!',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton _buildLogin(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        korisnikResponse = null;

        var username = _usernameController.text;
        var password = _passwordController.text;

        if (username == "" || password == "") {
          String errorMessage = "Unesite korisničko ime i lozinku!";

          // ignore: use_build_context_synchronously
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Greška!"),
                  content: Text(errorMessage),
                  actions: [
                    TextButton(
                      onPressed: () => {Navigator.of(context).pop()},
                      child: const Text("OK"),
                    ),
                  ],
                );
              });
        } else {
          Authorization.username = username;
          Authorization.password = password;

          await getData();

          if (korisnikResponse != null) {
            Authorization.korisnikId = korisnikResponse!.korisniciId;
            Authorization.email = korisnikResponse!.email;

            // ignore: use_build_context_synchronously
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
              (route) => false,
            );
          } else {
            String errorMessage =
                "Netačno korisničko ime ili lozinka. Molimo pokušajte ponovo.";

            // ignore: use_build_context_synchronously
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Greška!"),
                    content: Text(errorMessage),
                    actions: [
                      TextButton(
                        onPressed: () => {Navigator.of(context).pop()},
                        child: const Text("OK"),
                      ),
                    ],
                  );
                });
          }
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue.shade50,
        elevation: 8.0,
      ),
      child: SizedBox(
        width: double.infinity,
        child: Text(
          'Prijava',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18.0, color: Colors.grey.shade700),
        ),
      ),
    );
  }
}
