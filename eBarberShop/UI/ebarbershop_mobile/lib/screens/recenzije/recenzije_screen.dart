import 'dart:convert';

import 'package:ebarbershop_mobile/models/recenzije/recenzije.dart';
import 'package:ebarbershop_mobile/models/search_result.dart';
import 'package:ebarbershop_mobile/providers/recenzije_provider.dart';
import 'package:ebarbershop_mobile/screens/recenzije/recenzije_add_screen.dart';
import 'package:ebarbershop_mobile/screens/recenzije/recenzije_korisnika_screen.dart';
import 'package:ebarbershop_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class RecenzijeScreen extends StatefulWidget {
  const RecenzijeScreen({super.key});

  @override
  State<RecenzijeScreen> createState() => _RecenzijeScreenState();
}

class _RecenzijeScreenState extends State<RecenzijeScreen> {
  late RecenzijeProvider _recenzijeProvider;
  SearchResult<Recenzije>? recenzijeResult;
  bool isLoading = true;
  double ocjena = 0.0;

  double calculateAvarageRaiting(List<Recenzije> recenzije) {
    if (recenzije.isEmpty) {
      return 0.0;
    }

    double total = 0.0;
    for (var recenzija in recenzije) {
      total += recenzija.ocjena;
    }

    return total / recenzije.length;
  }

  @override
  void initState() {
    super.initState();
    _recenzijeProvider = context.read<RecenzijeProvider>();
    fetchRecenzije();
  }

  Future fetchRecenzije() async {
    recenzijeResult =
        await _recenzijeProvider.get(filter: {'isKorisnikInclude': true});

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10.0,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Recenzije',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                  fontFamily: 'Dosis',
                ),
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.star_border_purple500_outlined,
                  color: Colors.amber,
                  size: 25.0,
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Text(
                  formatNumber(
                    calculateAvarageRaiting(recenzijeResult!.result),
                  ),
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                    fontFamily: 'Dosis',
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const RecenzijeAddScreen())).then(
                      (value) => fetchRecenzije(),
                    );
                  },
                  child: Icon(
                    Icons.rate_review_outlined,
                    size: 35.0,
                    color: Colors.amberAccent[700]!.withOpacity(0.8),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const RecenzijeKorisnikaScreen()))
                        .then((value) => fetchRecenzije());
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 0.0, foregroundColor: Colors.black),
                  icon: const Icon(
                    Icons.keyboard_arrow_left,
                    color: Colors.black87,
                  ),
                  label: const Text('Pregled recenzije'),
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: GridView.builder(
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    mainAxisExtent: 250.0,
                  ),
                  itemCount: recenzijeResult!.result.length,
                  itemBuilder: (BuildContext context, int index) {
                    Recenzije recenzija = recenzijeResult!.result[index];
                    return GestureDetector(
                      onTap: () {
                        _buildShowBottomDialog(context, recenzija);
                      },
                      child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: Colors.grey[350],
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: recenzija.korisnik?.slika != "" &&
                                      recenzija.korisnik?.slika != null
                                  ? ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(100),
                                      child: Image(
                                        image: MemoryImage(
                                          base64Decode(recenzija
                                              .korisnik!.slika
                                              .toString()),
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(100),
                                      child: const Image(
                                        image: AssetImage(
                                            'assets/images/person_icon.png'),
                                      ),
                                    ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              recenzija.korisnik?.korisnickoIme ?? "",
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            IgnorePointer(
                              ignoring: true,
                              child: RatingBar.builder(
                                itemSize: 25.0,
                                initialRating: recenzija.ocjena,
                                minRating: 0,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding: const EdgeInsets.symmetric(
                                    horizontal: 2.0),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {},
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  recenzija.sadrzaj,
                                  overflow: TextOverflow.fade,
                                  maxLines: 5,
                                  style: const TextStyle(
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        );
  }

  Future<dynamic> _buildShowBottomDialog(
      BuildContext context, Recenzije recenzija) {
    return showModalBottomSheet(
      useSafeArea: true,
      showDragHandle: true,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(10.0),
          width: double.infinity,
          height: 450,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recenzija.korisnik?.korisnickoIme ?? "",
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  formatDate(recenzija.datumObjave),
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black45,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 30.0,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      recenzija.ocjena.toString(),
                      style: const TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.grey[350],
                  height: 40.0,
                ),
                Text(
                  recenzija.sadrzaj,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Colors.grey[850],
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
