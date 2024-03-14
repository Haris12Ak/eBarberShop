import 'package:ebarbershop_mobile/models/novosti/novosti.dart';
import 'package:ebarbershop_mobile/models/search_result.dart';
import 'package:ebarbershop_mobile/providers/novosti_provider.dart';
import 'package:ebarbershop_mobile/screens/novosti/gallery_list_screen.dart';
import 'package:ebarbershop_mobile/screens/novosti/novosti_detail_screen.dart';
import 'package:ebarbershop_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NovostiScreen extends StatefulWidget {
  const NovostiScreen({super.key});

  @override
  State<NovostiScreen> createState() => _NovostiScreenState();
}

class _NovostiScreenState extends State<NovostiScreen> {
  late NovostiProvider _novostiProvider;
  SearchResult<Novosti>? novostiResult;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    _novostiProvider = context.read<NovostiProvider>();

    fetchNovosti();
  }

  Future fetchNovosti() async {
    novostiResult = await _novostiProvider.get();

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Novosti',
                    style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.0,
                        color: Colors.grey[800]),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const GalleryListScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                      backgroundColor: Colors.blueGrey,
                      foregroundColor: Colors.white,
                    ),
                    icon: const Icon(
                      Icons.image,
                      size: 25.0,
                    ),
                    label: const Text('Galerija'),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: novostiResult!.result.length,
                  itemBuilder: (BuildContext context, int index) {
                    Novosti novost = novostiResult!.result[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    NovostiDetailScreen(novost: novost)));
                      },
                      child: Container(
                          color: Colors.white,
                          margin: const EdgeInsets.only(bottom: 10.0),
                          padding: const EdgeInsets.all(10.0),
                          height: 100,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: novost.slika != ""
                                      ? SizedBox(
                                          width: 80,
                                          height: 80,
                                          child: imageFromBase64String(
                                              novost.slika.toString()),
                                        )
                                      : const Image(
                                          image: AssetImage(
                                              'assets/images/image_not_available.png'),
                                          width: 80,
                                          height: 80,
                                        )),
                              const SizedBox(
                                width: 15.0,
                              ),
                              Expanded(
                                  child: Text(
                                novost.sadrzaj,
                                overflow: TextOverflow.fade,
                                maxLines: 4,
                                textAlign: TextAlign.justify,
                                style: const TextStyle(color: Colors.black87),
                              )),
                            ],
                          )),
                    );
                  },
                ),
              ),
            ],
          );
  }
}
