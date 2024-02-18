import 'package:ebarbershop_desktop/widgets/master_screen.dart';
import 'package:flutter/material.dart';

class UposleniciListScreen extends StatefulWidget {
  const UposleniciListScreen({super.key});

  @override
  State<UposleniciListScreen> createState() => _UposleniciListScreenState();
}

class _UposleniciListScreenState extends State<UposleniciListScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: 'Uposlenici',
      selectedOption: 'Uposlenici',
      child: Text("Uposlenici Screen"),
    );
  }
}