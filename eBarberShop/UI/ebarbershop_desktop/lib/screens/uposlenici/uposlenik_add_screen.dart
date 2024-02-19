import 'package:ebarbershop_desktop/widgets/button_back_widget.dart';
import 'package:ebarbershop_desktop/widgets/master_screen.dart';
import 'package:flutter/material.dart';

class UposlenikAddScreen extends StatefulWidget {
  const UposlenikAddScreen({super.key});

  @override
  State<UposlenikAddScreen> createState() => _UposlenikAddScreenState();
}

class _UposlenikAddScreenState extends State<UposlenikAddScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: 'Dodaj uposlenika',
      child: const Column(
        children: [
          ButtonBackWidget(),
        ],
      ),
    );
  }
}
