import 'package:ebarbershop_mobile/models/search_result.dart';
import 'package:ebarbershop_mobile/models/slike/slike.dart';
import 'package:ebarbershop_mobile/providers/slike_provider.dart';
import 'package:ebarbershop_mobile/screens/novosti/gallery_full_screen_image.dart';
import 'package:ebarbershop_mobile/utils/util.dart';
import 'package:ebarbershop_mobile/widgets/master_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GalleryListScreen extends StatefulWidget {
  const GalleryListScreen({super.key});

  @override
  State<GalleryListScreen> createState() => _GalleryListScreenState();
}

class _GalleryListScreenState extends State<GalleryListScreen> {
  late SlikeProvider _slikeProvider;
  SearchResult<Slike>? slikeResult;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _slikeProvider = context.read<SlikeProvider>();

    fetcSlike();
  }

  Future fetcSlike() async {
    var data = await _slikeProvider.get();

    if (mounted) {
      setState(() {
        slikeResult = data;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
        title: 'Galerija',
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : slikeResult!.result.isEmpty
                ? Center(
                    child: Text(
                      'Galerija prazna !',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w600),
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.all(7.0),
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.5,
                          mainAxisSpacing: 15.0,
                          crossAxisSpacing: 15.0,
                        ),
                        itemCount: slikeResult!.result.length,
                        itemBuilder: (BuildContext context, int index) {
                          Slike slika = slikeResult!.result[index];
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            GalleryFullScreenImage(
                                              slike: slikeResult!.result,
                                              index: index,
                                            )));
                              },
                              child: Container(
                                  child: imageFromBase64String(
                                      slika.slika.toString())));
                        }),
                  ));
  }
}
