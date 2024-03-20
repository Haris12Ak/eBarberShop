import 'package:ebarbershop_mobile/models/search_result.dart';
import 'package:ebarbershop_mobile/models/usluga/usluga.dart';
import 'package:ebarbershop_mobile/providers/usluga_provider.dart';
import 'package:ebarbershop_mobile/screens/rezervacije/rezervacija_screen.dart';
import 'package:ebarbershop_mobile/utils/util.dart';
import 'package:ebarbershop_mobile/widgets/usluge_opcije_screen.dart';
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
  bool isLoading = true;

  static const TextStyle _customStyle = TextStyle(
      fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.black54);

  @override
  void initState() {
    super.initState();

    _uslugaProvider = context.read<UslugaProvider>();

    fetchUsluge();
  }

  Future fetchUsluge() async {
    uslugeResult = await _uslugaProvider.get();

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
        : uslugeResult!.result.isEmpty
            ? Center(
                child: Text(
                  'Nema dostupnih usluga !',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w600),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 10.0),
                  const Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Usluge',
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Divider(
                    height: 28.0,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 5.0),
                  Expanded(
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 18.0,
                          crossAxisSpacing: 18.0,
                          mainAxisExtent: 250,
                        ),
                        itemCount: uslugeResult!.result.length,
                        itemBuilder: (BuildContext context, int index) {
                          Usluga usluga = uslugeResult!.result[index];
                          return GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                backgroundColor: Colors.grey[100],
                                useSafeArea: true,
                                showDragHandle: true,
                                isScrollControlled: true,
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    padding: const EdgeInsets.all(10.0),
                                    width: double.infinity,
                                    height: 650,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            usluga.naziv,
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.grey[800]),
                                          ),
                                          const SizedBox(height: 5.0),
                                          Text(
                                            'Cijena: ${formatNumber(usluga.cijena)} KM',
                                            style: _customStyle,
                                          ),
                                          const SizedBox(height: 10.0),
                                          const Text(
                                            'Opis:',
                                            style: _customStyle,
                                          ),
                                          const SizedBox(height: 5.0),
                                          Text(
                                            usluga.opis ?? "Nema opisa . . .",
                                            style: usluga.opis != "" &&
                                                    usluga.opis != null
                                                ? _customStyle
                                                : TextStyle(
                                                    fontSize: 15.0,
                                                    color: Colors.grey[500]),
                                          ),
                                          Divider(
                                            height: 30.0,
                                            thickness: 2.0,
                                            color: Colors.grey[400],
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          RezervacijaScreen(
                                                              usluga: usluga)));
                                            },
                                            child: const UslugeOpcijeScreen(
                                                text: 'Rezervacija',
                                                image: AssetImage(
                                                    'assets/images/calendar.png')),
                                          ),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          const UslugeOpcijeScreen(
                                              text: 'Galerija',
                                              image: AssetImage(
                                                  'assets/images/gallery.png')),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          const UslugeOpcijeScreen(
                                              text: 'Osoblje',
                                              image: AssetImage(
                                                  'assets/images/persons.webp')),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Card(
                              color: Colors.white,
                              shadowColor: Colors.black,
                              elevation: 1.0,
                              child: Container(
                                padding: const EdgeInsets.all(12.0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        height: 120,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30.0)),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          child: const Opacity(
                                            opacity: 0.8,
                                            child: Image(
                                              image: AssetImage(
                                                  'assets/images/image1.jpg'),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 12.0,
                                      ),
                                      Text(
                                        usluga.naziv,
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w700),
                                        overflow: TextOverflow.fade,
                                      ),
                                      const SizedBox(
                                        height: 2.0,
                                      ),
                                      Text('${formatNumber(usluga.cijena)} KM'),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  )
                ],
              );
  }
}
