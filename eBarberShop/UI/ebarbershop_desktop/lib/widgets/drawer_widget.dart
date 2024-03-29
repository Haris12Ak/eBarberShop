import 'package:ebarbershop_desktop/screens/home_screen.dart';
import 'package:ebarbershop_desktop/screens/narudzbe/narudzbe_list_screen.dart';
import 'package:ebarbershop_desktop/screens/novosti/novosti_list_screen.dart';
import 'package:ebarbershop_desktop/screens/proizvodi/proizvodi_list_screen.dart';
import 'package:ebarbershop_desktop/screens/rezervacije/rezervacije_screen.dart';
import 'package:ebarbershop_desktop/screens/rezervacije/rezervacije_termini_screen.dart';
import 'package:ebarbershop_desktop/screens/slike/slike_list_screen.dart';
import 'package:ebarbershop_desktop/screens/uposlenici/uposlenici_list_screen.dart';
import 'package:ebarbershop_desktop/utils/util.dart';
import 'package:ebarbershop_desktop/widgets/master_screen.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key, required this.widget});

  final MasterScreen widget;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0.0,
      backgroundColor: Colors.grey[200],
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 250,
            decoration: BoxDecoration(
              color: Colors.grey[100],
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 15.0,
                ),
                const Text(
                  'Barber Shop',
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      letterSpacing: 1.0,
                      fontStyle: FontStyle.italic),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Image(
                    width: 100,
                    height: 100,
                    image: AssetImage('assets/images/user_icon.png')),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  '${Authorization.username}',
                  style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2.0),
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text(
              'Pocetna',
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500),
            ),
            selectedColor: Colors.blue[800],
            selectedTileColor: Colors.grey[350],
            leading: const Icon(Icons.home),
            selected: widget.selectedOption == 'Pocetna',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
          ),
          ListTile(
            title: const Text(
              'Uposlenici',
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500),
            ),
            selectedColor: Colors.blue[800],
            selectedTileColor: Colors.grey[350],
            leading: const Icon(Icons.person),
            selected: widget.selectedOption == 'Uposlenici',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => const UposleniciListScreen()),
              );
            },
          ),
          ListTile(
            title: const Text(
              'Proizvodi',
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500),
            ),
            leading: const Icon(Icons.category),
            selectedColor: Colors.blue[800],
            selectedTileColor: Colors.grey[350],
            selected: widget.selectedOption == 'Proizvodi',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => const ProizvodiListScreen()),
              );
            },
          ),
          ListTile(
            title: const Text(
              'Slike',
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500),
            ),
            leading: const Icon(Icons.image),
            selectedColor: Colors.blue[800],
            selectedTileColor: Colors.grey[350],
            selected: widget.selectedOption == 'Slike',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => const SlikeListScreen()),
              );
            },
          ),
          ListTile(
            title: const Text(
              'Rezervacije',
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500),
            ),
            leading: const Icon(Icons.calendar_month),
            selectedColor: Colors.blue[800],
            selectedTileColor: Colors.grey[350],
            selected: widget.selectedOption == 'Rezervacije',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => const RezervacijeScreen()),
              );
            },
          ),
          ListTile(
            title: const Text(
              'Novosti',
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500),
            ),
            leading: const Icon(Icons.feed),
            selectedColor: Colors.blue[800],
            selectedTileColor: Colors.grey[350],
            selected: widget.selectedOption == 'Novosti',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => const NovostiListScreen()),
              );
            },
          ),
          ListTile(
            title: const Text(
              'Narudžbe',
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500),
            ),
            leading: const Icon(Icons.shopping_cart_checkout),
            selectedColor: Colors.blue[800],
            selectedTileColor: Colors.grey[350],
            selected: widget.selectedOption == 'Narudzbe',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => const NarudzbeListScreen()),
              );
            },
          ),
          ListTile(
            title: const Text(
              'Termini',
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500),
            ),
            leading: const Icon(Icons.more_time),
            selectedColor: Colors.blue[800],
            selectedTileColor: Colors.grey[350],
            selected: widget.selectedOption == 'Termini',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => const RezervacijeTerminiScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
