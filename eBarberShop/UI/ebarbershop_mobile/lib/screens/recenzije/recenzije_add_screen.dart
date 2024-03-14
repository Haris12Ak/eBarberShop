import 'package:ebarbershop_mobile/widgets/master_screen_widget.dart';
import 'package:flutter/material.dart';

class RecenzijeAddScreen extends StatefulWidget {
  const RecenzijeAddScreen({super.key});

  @override
  State<RecenzijeAddScreen> createState() => _RecenzijeAddScreenState();
}

class _RecenzijeAddScreenState extends State<RecenzijeAddScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(title: 'Dodajte recenziju', child: Container());
  }
}
