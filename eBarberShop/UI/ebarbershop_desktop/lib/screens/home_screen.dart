import 'package:ebarbershop_desktop/widgets/master_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: 'Home page',
      selectedOption: 'Pocetna',
      child: Text('Home Screen'),
    );
  }
}
