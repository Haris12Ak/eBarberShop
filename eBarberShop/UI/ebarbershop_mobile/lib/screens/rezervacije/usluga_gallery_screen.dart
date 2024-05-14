import 'package:ebarbershop_mobile/models/slike_usluge/slike_usluge.dart';
import 'package:ebarbershop_mobile/models/usluga/usluga.dart';
import 'package:ebarbershop_mobile/providers/slike_usluge_provider.dart';
import 'package:ebarbershop_mobile/widgets/gallery_full_image.dart';
import 'package:ebarbershop_mobile/widgets/gallery_list.dart';
import 'package:ebarbershop_mobile/widgets/master_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class UslugaGalleryScreen extends StatefulWidget {
  Usluga usluga;
  UslugaGalleryScreen({super.key, required this.usluga});

  @override
  State<UslugaGalleryScreen> createState() => _UslugaGalleryScreenState();
}

class _UslugaGalleryScreenState extends State<UslugaGalleryScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<List<SlikeUsluge>> fetchSlike(BuildContext context) async {
    var slikeUslugeProvider =
        Provider.of<SlikeUslugeProvider>(context, listen: false);
    var slikeUslugeResult =
        await slikeUslugeProvider.GetSlike(widget.usluga.uslugaId);

    return slikeUslugeResult.result;
  }

  void navigateToFullScreenImage(List<SlikeUsluge> data, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => GenericGalleryFullImage<SlikeUsluge>(
            data: (context) => fetchSlike(context),
            index: index,
            getOpisSlike: (slikeUsluge) =>
                slikeUsluge.opisSlike != null && slikeUsluge.opisSlike != ""
                    ? slikeUsluge.opisSlike.toString()
                    : "",
            getSlika: (slikeUsluge) => slikeUsluge.slikaUsluga.toString(),
            getDatumObjave: (slikeUsluge) => slikeUsluge.datumObjave!),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: 'Galerija - ${widget.usluga.naziv}',
      child: GenericGalleryList<SlikeUsluge>(
        fetchData: (context) => fetchSlike(context),
        getSlika: (slikeUsluge) => slikeUsluge.slikaUsluga.toString(),
        onTapImage: navigateToFullScreenImage,
      ),
    );
  }
}
