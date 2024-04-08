import 'dart:convert';

import 'package:ebarbershop_desktop/models/search_result.dart';
import 'package:ebarbershop_desktop/models/usluga/usluga.dart';
import 'package:ebarbershop_desktop/providers/usluga_provider.dart';
import 'package:ebarbershop_desktop/screens/usluge/usluga_detalji_screen.dart';
import 'package:ebarbershop_desktop/screens/usluge/usluge_edit_screen.dart';
import 'package:ebarbershop_desktop/utils/util.dart';
import 'package:ebarbershop_desktop/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UslugeScreen extends StatefulWidget {
  const UslugeScreen({super.key});

  @override
  State<UslugeScreen> createState() => _UslugeScreenState();
}

class _UslugeScreenState extends State<UslugeScreen> {
  late UslugaProvider _uslugaProvider;
  SearchResult<Usluga>? uslugeResult;
  List<Usluga> filteredUslugaData = [];
  bool isLoading = true;

  final TextEditingController _nazivUslugeController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _uslugaProvider = context.read<UslugaProvider>();

    fetchUsluge();
  }

  Future fetchUsluge() async {
    uslugeResult = await _uslugaProvider.get();

    if (mounted) {
      setState(() {
        filteredUslugaData = uslugeResult!.result;
        isLoading = false;
      });
    }
  }

  void filterData(String query) {
    List<Usluga> filteredList = [];

    if (query.isNotEmpty) {
      for (var item in uslugeResult!.result) {
        if (item.naziv.toLowerCase().contains(query.toLowerCase())) {
          filteredList.add(item);
        }
      }
    } else {
      filteredList = uslugeResult!.result;
    }

    setState(() {
      filteredUslugaData = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: 'Usluge',
      selectedOption: 'Usluge',
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context)
                          .push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => UslugeEditScreen(),
                        ),
                      )
                          .then((_) {
                        fetchUsluge();
                      });
                    },
                    icon: const Icon(Icons.add),
                    label: const Text(
                      'Dodaj novu uslugu',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 8.0,
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      minimumSize: const Size(100, 50),
                    ),
                  ),
                ),
                const SizedBox(height: 25.0),
                TextField(
                  controller: _nazivUslugeController,
                  decoration: const InputDecoration(
                    labelText: "Naziv usluge",
                    contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    filterData(value);
                  },
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredUslugaData.length,
                    itemBuilder: _buildListaUsluga,
                  ),
                ),
              ],
            ),
    );
  }

  Widget? _buildListaUsluga(BuildContext context, int index) {
    Usluga usluga = filteredUslugaData[index];
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade300,
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomLeft,
            colors: [
              Colors.black26,
              Colors.white12,
              Colors.white12,

              Colors.black26,
            ],
          ),
          borderRadius: BorderRadius.circular(15.0)),
      margin: const EdgeInsets.only(top: 20.0),
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: usluga.slika != "" && usluga.slika != null
                  ? Image(
                      height: 80,
                      fit: BoxFit.cover,
                      image: MemoryImage(
                        base64Decode(
                          usluga.slika.toString(),
                        ),
                      ),
                    )
                  : const Image(
                      height: 80,
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/image1.jpg'),
                    ),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Expanded(
            flex: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: 'Usluga: ',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.grey.shade900,
                              fontWeight: FontWeight.w600)),
                      TextSpan(
                          text: usluga.naziv,
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: 'Cijena: ',
                          style: TextStyle(
                              fontSize: 17.0,
                              color: Colors.grey.shade900,
                              fontWeight: FontWeight.w600)),
                      TextSpan(
                          text: '${formatNumber(usluga.cijena)} KM',
                          style: TextStyle(
                              fontSize: 17.0,
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  UslugaDetaljiScreen(
                                    usluga: usluga,
                                  )));
                    },
                    tooltip: 'Prikaži detalje',
                    icon: const Icon(
                      Icons.view_carousel,
                      size: 28,
                    )),
                const SizedBox(width: 5.0),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      UslugeEditScreen(usluga: usluga)))
                          .then((value) => fetchUsluge());
                    },
                    tooltip: 'Uredi',
                    icon: const Icon(Icons.edit_note, size: 28)),
                const SizedBox(width: 5.0),
                _buildDeleteUsluga(context, usluga),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconButton _buildDeleteUsluga(BuildContext context, Usluga usluga) {
    return IconButton(
      onPressed: () async {
        try {
          // ignore: use_build_context_synchronously
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Potvrda'),
              content: Text(
                  'Jeste li sigurni da želite ukloniti uslugu: ${usluga.naziv} !'),
              actions: [
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();

                    await _uslugaProvider.delete(usluga.uslugaId);

                    fetchUsluge();
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
      tooltip: 'Ukloni uslugu',
      icon: const Icon(Icons.close, size: 28),
    );
  }
}
