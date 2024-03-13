import 'package:ebarbershop_mobile/widgets/master_screen_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: 'Details',
      child: const Center(
        child: Text('Deatlji'),
      ),
    );
  }
}
