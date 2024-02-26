import 'package:ebarbershop_desktop/models/search_result.dart';
import 'package:ebarbershop_desktop/models/usluga/usluga.dart';
import 'package:ebarbershop_desktop/providers/usluga_provider.dart';
import 'package:ebarbershop_desktop/screens/rezervacije/rezervacije_usluge_screen.dart';
import 'package:ebarbershop_desktop/utils/util.dart';
import 'package:ebarbershop_desktop/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RezervacijeScreen extends StatefulWidget {
  const RezervacijeScreen({super.key});

  @override
  State<RezervacijeScreen> createState() => _RezervacijeScreenState();
}

class _RezervacijeScreenState extends State<RezervacijeScreen> {
  late UslugaProvider _uslugaProvider;
  late SearchResult<Usluga>? uslugaSearchResult;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    _uslugaProvider = context.read<UslugaProvider>();

    fetchUsluge();
  }

  Future fetchUsluge() async {
    uslugaSearchResult = await _uslugaProvider.get();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        title: 'Usluge',
        selectedOption: 'Rezervacije',
        child: isLoading
            ? Container()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.list,
                            size: 35,
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            'Odaberite uslugu',
                            style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.italic,
                                color: Colors.grey[800],
                                letterSpacing: 2.0),
                          ),
                        ],
                      )),
                  const SizedBox(
                    height: 25.0,
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: uslugaSearchResult!.result.length,
                      itemBuilder: (BuildContext context, int index) {
                        Usluga usluga = uslugaSearchResult!.result[index];
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            gradient: const LinearGradient(colors: [
                              Color.fromRGBO(177, 177, 177, 0.692),
                              Color.fromRGBO(206, 206, 206, 0.151)
                            ]),
                          ),
                          height: 150,
                          padding: const EdgeInsets.all(15.0),
                          margin: const EdgeInsets.fromLTRB(50.0, 0, 50.0, 0),
                          //color: Colors.grey[350],
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Opacity(
                                    opacity: 0.6,
                                    child: Image(
                                      image: AssetImage(
                                          'assets/images/image1.jpg'),
                                      width: 120,
                                      height: 120,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 30.0,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        usluga.naziv,
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.grey[800],
                                          letterSpacing: 2.0,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        'Trajanje: ${usluga.trajanje.toString()} min',
                                        style: const TextStyle(
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        'Cijena: ${formatNumber(usluga.cijena)} KM',
                                        style: const TextStyle(
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RezervacijeUslugeScreen(
                                              usluga: usluga,
                                            )),
                                  );
                                },
                                tooltip: 'Prikaži',
                                icon: Icon(
                                  Icons.checklist_rtl,
                                  color: Colors.grey[800],
                                  size: 35.0,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(
                        height: 50,
                      ),
                    ),
                  ),
                ],
              ));
  }
}
