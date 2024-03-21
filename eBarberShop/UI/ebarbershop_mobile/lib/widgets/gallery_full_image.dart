import 'dart:convert';

import 'package:ebarbershop_mobile/utils/util.dart';
import 'package:ebarbershop_mobile/widgets/master_screen_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GenericGalleryFullImage<T> extends StatefulWidget {
  final Future<List<T>> Function(BuildContext) data;
  final String? Function(T) getOpisSlike;
  final String Function(T) getSlika;
  final DateTime Function(T) getDatumObjave;
  final int index;

  const GenericGalleryFullImage(
      {Key? key,
      required this.data,
      required this.getOpisSlike,
      required this.getSlika,
      required this.getDatumObjave,
      required this.index})
      : super(key: key);

  @override
  State<GenericGalleryFullImage<T>> createState() =>
      _GenericGalleryFullImageState<T>();
}

class _GenericGalleryFullImageState<T>
    extends State<GenericGalleryFullImage<T>> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: FutureBuilder<List<T>>(
        future: widget.data(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Greška pri dohvatanju podataka'),
            );
          } else if (snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'Galerija prazna !',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 17.0,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w600),
              ),
            );
          } else {
            var items = snapshot.data!.toList();

            return PageView.builder(
              controller: _pageController,
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                var item = items[index];
                var opisSlike = widget.getOpisSlike(item);
                var slika = widget.getSlika(item);
                var datumObjave = widget.getDatumObjave(item);
                return Center(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image(
                        image: MemoryImage(
                          base64Decode(slika),
                        ),
                        fit: BoxFit.contain,
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Container(
                            margin: const EdgeInsets.only(right: 15.0),
                            child: ElevatedButton.icon(
                              onPressed: () {
                                showModalBottomSheet(
                                    useSafeArea: true,
                                    showDragHandle: true,
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        height: 450,
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(10.0),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Datum objave:',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black54),
                                              ),
                                              const SizedBox(
                                                height: 3.0,
                                              ),
                                              Text(
                                                formatDate(datumObjave),
                                                style: const TextStyle(
                                                  color: Colors.black45,
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 15.0,
                                              ),
                                              const Text(
                                                'Opis:',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black54),
                                              ),
                                              const SizedBox(
                                                height: 3.0,
                                              ),
                                              Text(
                                                opisSlike ?? "",
                                                style: const TextStyle(
                                                  color: Colors.black45,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              },
                              style: ElevatedButton.styleFrom(
                                alignment: Alignment.center,
                                elevation: 0.0,
                                foregroundColor: Colors.black54,
                                backgroundColor: Colors.transparent,
                                textStyle: const TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                ),
                              ),
                              icon: const Icon(Icons.description),
                              label: const Text('Prikaži opis'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

/*
 * Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Text(
                                  'Opis:',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black38),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  opisSlike ?? "",
                                  style: const TextStyle(
                                    color: Colors.black38,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
 */