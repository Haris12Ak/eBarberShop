import 'dart:convert';

import 'package:flutter/material.dart';

class GenericGalleryList<T> extends StatelessWidget {
  final Future<List<T>> Function(BuildContext) fetchData;
  final String Function(T) getSlika;
  final void Function(List<T>, int) onTapImage;

  const GenericGalleryList({
    Key? key,
    required this.fetchData,
    required this.getSlika,
    required this.onTapImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<T>>(
      future: fetchData(context),
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

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
              mainAxisSpacing: 15.0,
              crossAxisSpacing: 15.0,
            ),
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              var item = items[index];
              var slika = getSlika(item);
              return GestureDetector(
                onTap: () {
                  onTapImage(items, index);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image(
                    image: MemoryImage(
                      base64Decode(slika),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
