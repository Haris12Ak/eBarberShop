import 'package:ebarbershop_desktop/widgets/master_screen.dart';
import 'package:flutter/material.dart';

class ProizvodiListScreen extends StatefulWidget {
  const ProizvodiListScreen({super.key});

  @override
  State<ProizvodiListScreen> createState() => _ProizvodiListScreenState();
}

class _ProizvodiListScreenState extends State<ProizvodiListScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: 'Proizvodi',
      selectedOption: 'Proizvodi',
      child: Text('Proizvodi Screen'),
    );
  }
}
