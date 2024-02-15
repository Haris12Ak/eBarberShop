import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscured = true;
  IconData _icon = Icons.visibility_off;

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
                  const TextField(
                    decoration: InputDecoration(
                        labelText: 'Korisnicko ime',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email)),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextField(
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
      onPressed: () {},
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
