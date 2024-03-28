import 'dart:convert';

import 'package:ebarbershop_mobile/models/proizvodi/proizvodi.dart';
import 'package:ebarbershop_mobile/utils/util.dart';
import 'package:ebarbershop_mobile/widgets/master_screen_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProizvodDetaljiScreen extends StatefulWidget {
  Proizvodi proizvod;
  ProizvodDetaljiScreen({super.key, required this.proizvod});

  @override
  State<ProizvodDetaljiScreen> createState() => _ProizvodDetaljiScreenState();
}

class _ProizvodDetaljiScreenState extends State<ProizvodDetaljiScreen> {
  static final TextStyle _customStyle = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
    color: Colors.grey[700],
    fontFamily: 'Dosis',
    letterSpacing: 1,
  );

  static final TextStyle _customHeaderStyle = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w600,
    color: Colors.grey[900],
    fontFamily: 'Dosis',
    letterSpacing: 1,
  );

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: 'Detalji proizvoda',
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: widget.proizvod.slika != "" &&
                            widget.proizvod.slika != null
                        ? Image(
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                            image: MemoryImage(
                              base64Decode(
                                widget.proizvod.slika.toString(),
                              ),
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade200),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: const Image(
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  'assets/images/image_not_available.png'),
                            ),
                          ),
                  ),
                  const SizedBox(width: 20.0),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.proizvod.naziv,
                          style: _customHeaderStyle,
                          overflow: TextOverflow.clip,
                          softWrap: true,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          widget.proizvod.vrstaProizvodaNaziv ?? "",
                          style: _customStyle,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${formatNumber(widget.proizvod.cijena)} KM',
                          style: _customStyle,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                elevation: 0.0, backgroundColor: Colors.white),
                            onPressed: () {},
                            icon: Icon(
                              Icons.add_shopping_cart,
                              color: Colors.grey[900],
                            ),
                            label: Text(
                              'Dodaj',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.w600),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'Opis proizvoda',
              style: _customHeaderStyle,
            ),
            const SizedBox(height: 5),
            Text(
              widget.proizvod.opis ?? "Nema opisa . . .",
              style: _customStyle,
            )
          ],
        ),
      ),
    );
  }
}
