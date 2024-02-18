import 'package:ebarbershop_desktop/models/korisnik/korisnik.dart';
import 'package:ebarbershop_desktop/providers/login_provider.dart';
import 'package:ebarbershop_desktop/screens/home_screen.dart';
import 'package:ebarbershop_desktop/utils/util.dart';
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
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Prijava',
          style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.w600,
              letterSpacing: 2.0,
              color: Colors.black45),
        ),
        elevation: 0.0,
        backgroundColor: Colors.grey[200],
      ),
      body: Center(
        child: SizedBox(
          width: 500,
          height: 550,
          child: Card(
            color: Colors.grey[200],
            elevation: 0.0,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Image(
                      width: 180,
                      height: 180,
                      image: AssetImage('assets/images/logo.png')),
                  Divider(
                    height: 80.0,
                    color: Colors.grey[400],
                  ),
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                        labelText: 'Korisnicko ime',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email)),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    controller: _passwordController,
                    obscureText: _isObscured,
                    decoration: InputDecoration(
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
                      prefixIcon: const Icon(Icons.password),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  buildLogin(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton buildLogin() {
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

            // ignore: use_build_context_synchronously
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
              (route) => false,
            );
          } else {
            _usernameController.text = "";
            _passwordController.text = "";

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
        backgroundColor: Colors.grey[400],
        foregroundColor: Colors.white,
        minimumSize: const Size(120, 50),
        textStyle: const TextStyle(
          fontSize: 17.0,
          fontWeight: FontWeight.w500,
          letterSpacing: 2.0,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        elevation: 5.0,
      ),
      child: const Text('Prijava'),
    );
  }
}
