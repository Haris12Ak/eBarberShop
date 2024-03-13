import 'package:ebarbershop_mobile/models/novosti/novosti.dart';
import 'package:ebarbershop_mobile/utils/util.dart';
import 'package:ebarbershop_mobile/widgets/master_screen_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NovostiDetailScreen extends StatefulWidget {
  Novosti novost;
  NovostiDetailScreen({super.key, required this.novost});

  @override
  State<NovostiDetailScreen> createState() => _NovostiDetailScreenState();
}

class _NovostiDetailScreenState extends State<NovostiDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
        title: 'Detalji',
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 50.0,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: 150,
                  height: 150,
                  child: widget.novost.slika != ""
                      ? imageFromBase64String(widget.novost.slika.toString())
                      : const Image(
                          image: AssetImage(
                              'assets/images/image_not_available.png'),
                          width: 150,
                          height: 150,
                        ),
                ),
              ),
              const SizedBox(
                height: 50.0,
              ),
              Text(
                'Objavio: ${widget.novost.korisnikImePrezime ?? ""}',
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey[800],
                    fontSize: 15),
              ),
              const SizedBox(
                height: 2.0,
              ),
              Text(
                'Datum: ${formatDate(widget.novost.datumObjave)}',
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey[600],
                    fontSize: 13),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                widget.novost.naslov,
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
                widget.novost.sadrzaj,
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
