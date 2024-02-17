import 'package:ebarbershop_desktop/screens/login_screen.dart';
import 'package:ebarbershop_desktop/utils/util.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pocetna stranica'),
        elevation: 0.0,
        backgroundColor: Colors.grey[200],
        actions: [
          Align(
            alignment: Alignment.center,
            child: Row(children: [
              Text('Prijavljeni korisnik: ${Authorization.username}',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(width: 20),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LoginScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  child: const Text('Odjava')),
            ]),
          )
        ],
      ),
      body: Container(),
    );
  }
}
