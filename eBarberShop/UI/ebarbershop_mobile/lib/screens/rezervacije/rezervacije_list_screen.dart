import 'package:flutter/material.dart';

class RezervacijeListScreen extends StatefulWidget {
  const RezervacijeListScreen({super.key});

  @override
  State<RezervacijeListScreen> createState() => _RezervacijeListScreenState();
}

class _RezervacijeListScreenState extends State<RezervacijeListScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Rezervacije'),
    );
  }
}