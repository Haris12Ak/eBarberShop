import 'package:ebarbershop_mobile/screens/novosti/novosti_screen.dart';
import 'package:ebarbershop_mobile/screens/profil/profil_screen.dart';
import 'package:ebarbershop_mobile/screens/proizvodi/proizvodi_screen.dart';
import 'package:ebarbershop_mobile/screens/recenzije/recenzije_screen.dart';
import 'package:ebarbershop_mobile/screens/rezervacije/usluge_screen.dart';
import 'package:ebarbershop_mobile/utils/util.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    NovostiScreen(),
    UslugeScreen(),
    RecenzijeScreen(),
    ProizvodiScreen(),
    ProfilScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[50],
        appBar: AppBar(
          backgroundColor: Colors.lightBlue[100],
          elevation: 4.0,
          title: const Text(
            'BarberShop',
            style: TextStyle(
                fontStyle: FontStyle.italic, fontWeight: FontWeight.w700),
          ),
          actions: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Row(
                  children: [
                    const Text(
                      'Dobro došli!',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      '${Authorization.username}',
                      style: const TextStyle(
                        letterSpacing: 1.0,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Početna',
                backgroundColor: Colors.white60),
            BottomNavigationBarItem(
                icon: Icon(Icons.date_range),
                label: 'Rezervacije',
                backgroundColor: Colors.white60),
            BottomNavigationBarItem(
                icon: Icon(Icons.star),
                label: 'Recenzije',
                backgroundColor: Colors.white60),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: 'Proizvodi',
                backgroundColor: Colors.white60),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profil',
                backgroundColor: Colors.white60),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.grey.shade800,
          unselectedItemColor: Colors.black45,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
          elevation: 12.0,
          onTap: _onItemTapped,
        ));
  }
}
