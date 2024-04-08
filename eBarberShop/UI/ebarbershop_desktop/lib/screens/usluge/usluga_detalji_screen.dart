import 'dart:convert';

import 'package:ebarbershop_desktop/models/search_result.dart';
import 'package:ebarbershop_desktop/models/slike_usluge/slike_usluge.dart';
import 'package:ebarbershop_desktop/models/usluga/usluga.dart';
import 'package:ebarbershop_desktop/providers/slike_provider.dart';
import 'package:ebarbershop_desktop/providers/slike_usluge_provider.dart';
import 'package:ebarbershop_desktop/screens/usluge/usluga_slike_add_screen.dart';
import 'package:ebarbershop_desktop/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class UslugaDetaljiScreen extends StatefulWidget {
  Usluga usluga;
  UslugaDetaljiScreen({super.key, required this.usluga});

  @override
  State<UslugaDetaljiScreen> createState() => _UslugaDetaljiScreenState();
}

class _UslugaDetaljiScreenState extends State<UslugaDetaljiScreen> {
  late SlikeUslugeProvider _slikeUslugeProvider;
  late SlikeProvider _slikeProvider;
  SearchResult<SlikeUsluge>? slikeUslugeResult;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    _slikeUslugeProvider = context.read<SlikeUslugeProvider>();
    _slikeProvider = context.read<SlikeProvider>();

    fetchSlike();
  }

  Future fetchSlike() async {
    slikeUslugeResult =
        await _slikeUslugeProvider.GetSlike(widget.usluga.uslugaId);

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Detalji usluge',
          style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.0,
              color: Colors.black54,
              fontStyle: FontStyle.italic),
        ),
        elevation: 0.0,
        backgroundColor: Colors.grey[300],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                _buildUslugaDetail(),
                const Divider(
                  thickness: 3,
                  height: 40.0,
                  indent: 20.0,
                  endIndent: 20.0,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Galerija slika (${slikeUslugeResult!.count})',
                        style: const TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          UslugaSlikeAddScreen(
                                              uslugaNaziv: widget.usluga.naziv,
                                              uslugaId:
                                                  widget.usluga.uslugaId)))
                              .then((value) => fetchSlike());
                        },
                        icon: const Icon(Icons.add_photo_alternate_outlined),
                        label: const Text(
                          'Dodaj sliku',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 8.0,
                          shape: const BeveledRectangleBorder(
                              borderRadius: BorderRadius.zero),
                          backgroundColor: Colors.blueGrey,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(100, 50),
                        ),
                      ),
                    ],
                  ),
                ),
                if (slikeUslugeResult!.result.isNotEmpty)
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.0, bottom: 10.0),
                      child: Text(
                        'Odaberite sliku za detaljan pregled slike!',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 10,
                        childAspectRatio: 1,
                        mainAxisSpacing: 15.0,
                        crossAxisSpacing: 15.0,
                      ),
                      itemCount: slikeUslugeResult!.result.length,
                      itemBuilder: (BuildContext context, int index) {
                        SlikeUsluge slikaUsluge =
                            slikeUslugeResult!.result[index];
                        return GestureDetector(
                          onTap: () {
                            _buildShowDetailImage(context, slikaUsluge);
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image(
                              image: MemoryImage(
                                base64Decode(
                                    slikaUsluge.slikaUsluga.toString()),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Container _buildUslugaDetail() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.elliptical(100, 50),
          bottomRight: Radius.elliptical(100, 50),
        ),
        color: Colors.grey.shade300,
        image: const DecorationImage(
            opacity: .1,
            fit: BoxFit.cover,
            image: AssetImage('assets/images/background_image.jpg')),
      ),
      padding: const EdgeInsets.fromLTRB(35, 20, 35, 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.usluga.naziv,
            style: const TextStyle(
                fontSize: 25.0,
                letterSpacing: 1.0,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            'Cijena: ${formatNumber(widget.usluga.cijena)} KM',
            style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
                color: Colors.black),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            'Trajanje: ${widget.usluga.trajanje} min',
            style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
                color: Colors.black),
          ),
          const SizedBox(
            height: 20.0,
          ),
          const Text(
            'Opis: ',
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
                color: Colors.black),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Text(
            widget.usluga.opis ?? "",
            style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w500,
                color: Colors.black),
          ),
        ],
      ),
    );
  }

  Future<dynamic> _buildShowDetailImage(
      BuildContext context, SlikeUsluge slikaUsluge) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                tooltip: 'Close',
                icon: const Icon(
                  Icons.close,
                  size: 25.0,
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.contain,
                          image: MemoryImage(base64Decode(
                              slikaUsluge.slikaUsluga.toString())))),
                ),
              ),
              const SizedBox(height: 10.0),
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Datum objave',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        formatDate(slikaUsluge.datumObjave),
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(height: 10.0),
                      const Text(
                        'Opis',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 5.0),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Text(
                            slikaUsluge.opisSlike ?? "",
                            style: const TextStyle(
                                overflow: TextOverflow.fade, fontSize: 16.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      try {
                        // ignore: use_build_context_synchronously
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Potvrda'),
                            content: const Text(
                                'Jeste li sigurni da želite ukloniti sliku!'),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  await _slikeProvider
                                      .delete(slikaUsluge.slikaId);

                                  fetchSlike();

                                  // ignore: use_build_context_synchronously
                                  Navigator.of(context).pop();

                                  // ignore: use_build_context_synchronously
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Da'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Ne'),
                              ),
                            ],
                          ),
                        );
                      } on Exception catch (e) {
                        // ignore: use_build_context_synchronously
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text("Error"),
                            content: Text(e.toString()),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("OK"),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.delete_forever),
                    label: const Text(
                      'Ukloni sliku',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 8.0,
                      shape: const BeveledRectangleBorder(
                          borderRadius: BorderRadius.zero),
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(100, 50),
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
}
