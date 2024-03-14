import 'package:ebarbershop_mobile/models/recenzije/recenzije.dart';
import 'package:ebarbershop_mobile/models/search_result.dart';
import 'package:ebarbershop_mobile/providers/recenzije_provider.dart';
import 'package:ebarbershop_mobile/screens/recenzije/recenzije_add_screen.dart';
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
  SearchResult<Recenzije>? recenzijeRezult;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _recenzijeProvider = context.read<RecenzijeProvider>();
    fetchRecenzije();
  }

  Future fetchRecenzije() async {
    recenzijeRezult = await _recenzijeProvider.get();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 10.0,
              ),
              const Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Recenzije',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const RecenzijeAddScreen()));
                  },
                  child: Icon(
                    Icons.rate_review,
                    size: 35.0,
                    color: Colors.amberAccent[700]!.withOpacity(0.8),
                  ),
                ),
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
                      mainAxisExtent: 280.0,
                    ),
                    itemCount: recenzijeRezult!.result.length,
                    itemBuilder: (BuildContext context, int index) {
                      Recenzije recenzija = recenzijeRezult!.result[index];
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
                              const Image(
                                image:
                                    AssetImage('assets/images/person_icon.png'),
                                width: 80,
                                height: 80,
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                '${recenzija.imeKorisnika} ${recenzija.prezimeKorisnika}',
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
                                  initialRating: recenzija.ocjena.toDouble(),
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
                                child: Text(
                                  recenzija.sadrzaj,
                                  overflow: TextOverflow.fade,
                                  textAlign: TextAlign.left,
                                  maxLines: 6,
                                  style: const TextStyle(
                                    color: Colors.black87,
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
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${recenzija.imeKorisnika} ${recenzija.prezimeKorisnika}',
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
        );
      },
    );
  }
}
