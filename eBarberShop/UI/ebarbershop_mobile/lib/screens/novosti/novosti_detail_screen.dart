import 'dart:convert';

import 'package:ebarbershop_mobile/models/novosti/novosti.dart';
import 'package:ebarbershop_mobile/providers/novosti_provider.dart';
import 'package:ebarbershop_mobile/utils/util.dart';
import 'package:ebarbershop_mobile/widgets/master_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class NovostiDetailScreen extends StatefulWidget {
  int novostId;
  NovostiDetailScreen({super.key, required this.novostId});

  @override
  State<NovostiDetailScreen> createState() => _NovostiDetailScreenState();
}

class _NovostiDetailScreenState extends State<NovostiDetailScreen> {
  late NovostiProvider _novostiProvider;
  late Novosti novost;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    _novostiProvider = context.read<NovostiProvider>();

    getNovost();
  }

  Future getNovost() async {
    novost = await _novostiProvider.getById(widget.novostId);

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
        title: 'Detalji',
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                      height: 300,
                      width: double.infinity,
                      child: novost.slika != "" && novost.slika != null
                          ? Image(
                              image: MemoryImage(
                                base64Decode(novost.slika.toString()),
                              ),
                              fit: BoxFit.contain,
                            )
                          : const Image(
                              image: AssetImage(
                                  'assets/images/image_not_available.png'),
                              fit: BoxFit.contain,
                            ),
                    ),
                    const SizedBox(
                      height: 18.0,
                    ),
                    Text(
                      'Objavio: ${novost.korisnikImePrezime ?? ""}',
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey[800],
                          fontSize: 15),
                    ),
                    const SizedBox(
                      height: 2.0,
                    ),
                    Text(
                      'Datum: ${formatDate(novost.datumObjave)}',
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey[600],
                          fontSize: 13),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      novost.naslov,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      novost.sadrzaj,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ));
  }
}
