import 'package:ebarbershop_desktop/screens/home_screen.dart';
import 'package:ebarbershop_desktop/screens/narudzbe/narudzbe_list_screen.dart';
import 'package:ebarbershop_desktop/screens/novosti/novosti_list_screen.dart';
import 'package:ebarbershop_desktop/screens/proizvodi/proizvodi_list_screen.dart';
import 'package:ebarbershop_desktop/screens/rezervacije/rezervacije_screen.dart';
import 'package:ebarbershop_desktop/screens/rezervacije/rezervacije_termini_screen.dart';
import 'package:ebarbershop_desktop/screens/slike/slike_list_screen.dart';
import 'package:ebarbershop_desktop/screens/uposlenici/uposlenici_list_screen.dart';
import 'package:ebarbershop_desktop/screens/usluge/usluge_screen.dart';
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
              'Početna',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
            ),
            horizontalTitleGap: 20.0,
            contentPadding: const EdgeInsets.fromLTRB(25.0, 5.0, 30.0, 5.0),
            selectedColor: Colors.blue[800],
            selectedTileColor: Colors.grey[350],
            leading: const Icon(Icons.home, size: 28),
            selected: widget.selectedOption == 'Pocetna',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
          ),
          Divider(height: 8.0, thickness: 2.0, color: Colors.grey.shade300),
          ListTile(
            title: const Text(
              'Uposlenici',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
            ),
            horizontalTitleGap: 20.0,
            contentPadding: const EdgeInsets.fromLTRB(25.0, 5.0, 30.0, 5.0),
            selectedColor: Colors.blue[800],
            selectedTileColor: Colors.grey[350],
            leading: const Icon(Icons.people_outline_outlined, size: 28),
            selected: widget.selectedOption == 'Uposlenici',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => const UposleniciListScreen()),
              );
            },
          ),
          Divider(height: 8.0, thickness: 2.0, color: Colors.grey.shade300),
          ListTile(
            title: const Text(
              'Proizvodi',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
            ),
            horizontalTitleGap: 20.0,
            contentPadding: const EdgeInsets.fromLTRB(25.0, 5.0, 30.0, 5.0),
            leading: const Icon(Icons.category, size: 28),
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
          Divider(height: 8.0, thickness: 2.0, color: Colors.grey.shade300),
          ListTile(
            title: const Text(
              'Slike',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
            ),
            horizontalTitleGap: 20.0,
            contentPadding: const EdgeInsets.fromLTRB(25.0, 5.0, 30.0, 5.0),
            leading: const Icon(Icons.image, size: 28),
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
          Divider(height: 8.0, thickness: 2.0, color: Colors.grey.shade300),
          ListTile(
            title: const Text(
              'Rezervacije',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
            ),
            horizontalTitleGap: 20.0,
            contentPadding: const EdgeInsets.fromLTRB(25.0, 5.0, 30.0, 5.0),
            leading: const Icon(Icons.calendar_month, size: 28),
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
          Divider(height: 8.0, thickness: 2.0, color: Colors.grey.shade300),
          ListTile(
            title: const Text(
              'Novosti',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
            ),
            horizontalTitleGap: 20.0,
            contentPadding: const EdgeInsets.fromLTRB(25.0, 5.0, 30.0, 5.0),
            leading: const Icon(Icons.feed, size: 28),
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
          Divider(height: 8.0, thickness: 2.0, color: Colors.grey.shade300),
          ListTile(
            title: const Text(
              'Narudžbe',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
            ),
            horizontalTitleGap: 20.0,
            contentPadding: const EdgeInsets.fromLTRB(25.0, 5.0, 30.0, 5.0),
            leading: const Icon(Icons.shopping_cart_checkout, size: 28),
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
          Divider(height: 8.0, thickness: 2.0, color: Colors.grey.shade300),
          ListTile(
            title: const Text(
              'Termini',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
            ),
            horizontalTitleGap: 20.0,
            contentPadding: const EdgeInsets.fromLTRB(25.0, 5.0, 30.0, 5.0),
            leading: const Icon(Icons.more_time, size: 28),
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
          Divider(height: 8.0, thickness: 2.0, color: Colors.grey.shade300),
          ListTile(
            title: const Text(
              'Usluge',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
            ),
            horizontalTitleGap: 20.0,
            contentPadding: const EdgeInsets.fromLTRB(25.0, 5.0, 30.0, 5.0),
            leading: const Icon(Icons.miscellaneous_services, size: 28),
            selectedColor: Colors.blue[800],
            selectedTileColor: Colors.grey[350],
            selected: widget.selectedOption == 'Usluge',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const UslugeScreen()),
              );
            },
          ),
          Divider(height: 8.0, thickness: 2.0, color: Colors.grey.shade300),
        ],
      ),
    );
  }
}
