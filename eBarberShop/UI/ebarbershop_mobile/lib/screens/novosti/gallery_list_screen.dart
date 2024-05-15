import 'package:ebarbershop_mobile/models/slike/slike.dart';
import 'package:ebarbershop_mobile/providers/slike_provider.dart';
import 'package:ebarbershop_mobile/widgets/gallery_full_image.dart';
import 'package:ebarbershop_mobile/widgets/gallery_list.dart';
import 'package:ebarbershop_mobile/widgets/master_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GalleryListScreen extends StatefulWidget {
  const GalleryListScreen({super.key});

  @override
  State<GalleryListScreen> createState() => _GalleryListScreenState();
}

class _GalleryListScreenState extends State<GalleryListScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<List<Slike>> fetchSlike(BuildContext context) async {
    var slikeProvider = Provider.of<SlikeProvider>(context, listen: false);
    var slikeResult = await slikeProvider.get();

    slikeResult.result
        .sort((a, b) => b.datumPostavljanja.compareTo(a.datumPostavljanja));

    return slikeResult.result;
  }

  void navigateToFullScreenImage(List<Slike> data, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => GenericGalleryFullImage<Slike>(
            data: (context) => fetchSlike(context),
            index: index,
            getOpisSlike: (slike) => slike.opis != null && slike.opis != ""
                ? slike.opis.toString()
                : "",
            getSlika: (slike) => slike.slika.toString(),
            getDatumObjave: (slikeUsluge) => slikeUsluge.datumPostavljanja),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: 'Galerija',
      child: GenericGalleryList<Slike>(
        fetchData: (context) => fetchSlike(context),
        getSlika: (slike) => slike.slika.toString(),
        onTapImage: navigateToFullScreenImage,
      ),
    );
  }
}
