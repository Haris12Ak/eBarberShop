import 'package:ebarbershop_mobile/models/slike/slike.dart';
import 'package:ebarbershop_mobile/utils/util.dart';
import 'package:ebarbershop_mobile/widgets/master_screen_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GalleryFullScreenImage extends StatefulWidget {
  List<Slike> slike;
  int index;
  GalleryFullScreenImage({super.key, required this.slike, required this.index});

  @override
  State<GalleryFullScreenImage> createState() => _GalleryFullScreenImageState();
}

class _GalleryFullScreenImageState extends State<GalleryFullScreenImage> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.slike.length,
        itemBuilder: (BuildContext context, int index) {
          Slike slika = widget.slike[index];
          return Center(
            child: Container(
              child: imageFromBase64String(slika.slika.toString()),
            ),
          );
        },
      ),
    );
  }
}
