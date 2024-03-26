import 'package:ebarbershop_mobile/models/search_result.dart';
import 'package:ebarbershop_mobile/models/uposlenik/uposlenik.dart';
import 'package:ebarbershop_mobile/models/usluga/usluga.dart';
import 'package:ebarbershop_mobile/providers/uposlenik_provider.dart';
import 'package:ebarbershop_mobile/providers/usluga_provider.dart';
import 'package:ebarbershop_mobile/screens/rezervacije/rezervacija_screen.dart';
import 'package:ebarbershop_mobile/screens/rezervacije/uposlenik_info_screen.dart';
import 'package:ebarbershop_mobile/screens/rezervacije/usluga_gallery_screen.dart';
import 'package:ebarbershop_mobile/utils/util.dart';
import 'package:ebarbershop_mobile/widgets/usluge_opcije_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class UslugeScreen extends StatefulWidget {
  const UslugeScreen({super.key});

  @override
  State<UslugeScreen> createState() => _UslugeScreenState();
}

class _UslugeScreenState extends State<UslugeScreen> {
  late UslugaProvider _uslugaProvider;
  SearchResult<Usluga>? uslugeResult;
  late UposlenikProvider _uposlenikProvider;
  SearchResult<Uposlenik>? uposleniciResult;
  bool isLoading = true;

  static const TextStyle _customStyle = TextStyle(
      fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.black54);

  static final TextStyle _titleStyle = TextStyle(
    fontSize: 26.0,
    fontWeight: FontWeight.bold,
    color: Colors.grey[800],
    fontFamily: 'EduNSWACTFoundation',
    letterSpacing: 1.0,
  );

  @override
  void initState() {
    super.initState();

    _uslugaProvider = context.read<UslugaProvider>();
    _uposlenikProvider = context.read<UposlenikProvider>();

    fetchData();
  }

  Future fetchData() async {
    uslugeResult = await _uslugaProvider.get();
    uposleniciResult = await _uposlenikProvider.get();

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10.0,
              ),
              Text('Zdravo: ${Authorization.username} !', style: _titleStyle),
              const SizedBox(
                height: 5.0,
              ),
              const Text(
                'Za detalje o cijenama i dostupnim terminima, molimo vas da odaberete željenu uslugu i termin. ',
                style: TextStyle(
                  fontSize: 23.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontFamily: 'EduNSWACTFoundation',
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Text('Usluge', style: _titleStyle),
              const SizedBox(
                height: 2.0,
              ),
              SizedBox(
                height: 200,
                child: uslugeResult!.result.isEmpty
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
                    : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          mainAxisExtent: 170,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: uslugeResult!.result.length,
                        itemBuilder: _buildItemListaUsluga,
                      ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text('Frizeri', style: _titleStyle),
              const SizedBox(
                height: 2.0,
              ),
              uposleniciResult!.result.isEmpty
                  ? Center(
                      child: Text(
                        'Nema dostupnih frizera !',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 17.0,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: uposleniciResult!.result.length,
                        itemBuilder: _buildItemListaUposlenika,
                      ),
                    ),
            ],
          );
  }

  Widget? _buildItemListaUsluga(context, index) {
    Usluga usluga = uslugeResult!.result[index];
    return GestureDetector(
      onTap: () {
        _buildPrikazOpcijeUsluge(context, usluga);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade500,
          borderRadius: BorderRadius.circular(25.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.white24,
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(3, 3),
            ),
          ],
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomLeft,
            colors: [
              Colors.black38,
              Colors.white12,
              Colors.white12,
              Colors.black38,
            ],
          ),
        ),
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.fromLTRB(5.0, 8.0, 13.0, 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100.0),
              child: const Opacity(
                opacity: 0.8,
                child: Image(
                  image: AssetImage(
                    'assets/images/image1.jpg',
                  ),
                  fit: BoxFit.cover,
                  width: 100,
                  height: 100,
                ),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              usluga.naziv,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> _buildPrikazOpcijeUsluge(context, Usluga usluga) {
    return showModalBottomSheet(
      backgroundColor: Colors.white70,
      useSafeArea: true,
      showDragHandle: true,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(8.0),
          width: double.infinity,
          height: 500,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        usluga.naziv,
                        style: TextStyle(
                          fontSize: 23.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                          fontFamily: 'EduNSWACTFoundation',
                          letterSpacing: 1.0,
                        ),
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
                        style: usluga.opis != "" && usluga.opis != null
                            ? _customStyle
                            : TextStyle(
                                fontSize: 15.0, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 40.0,
                  thickness: 2.0,
                  color: Colors.black38,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: const EdgeInsets.all(40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      RezervacijaScreen(usluga: usluga)));
                        },
                        child: const UslugeOpcijeScreen(
                            text: 'Rezervacija',
                            image: AssetImage('assets/images/calendar.png')),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      UslugaGalleryScreen(usluga: usluga)));
                        },
                        child: const UslugeOpcijeScreen(
                            text: 'Galerija',
                            image: AssetImage('assets/images/gallery.png')),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget? _buildItemListaUposlenika(BuildContext context, int index) {
    Uposlenik uposlenik = uposleniciResult!.result[index];
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade500,
        borderRadius: BorderRadius.circular(15.0),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomLeft,
          colors: [
            Colors.black38,
            Colors.white12,
            Colors.black38,
          ],
        ),
      ),
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.fromLTRB(5.0, 8.0, 5.0, 8.0),
      child: ListTile(
        title: Text(
          '${uposlenik.ime} ${uposlenik.prezime}',
          style: const TextStyle(
              fontWeight: FontWeight.w500, color: Colors.black87),
        ),
        subtitle: IgnorePointer(
          ignoring: true,
          child: RatingBar.builder(
            itemSize: 22.0,
            initialRating: uposlenik.prosjecnaOcjena,
            minRating: 0,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {},
          ),
        ),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: const Opacity(
            opacity: 0.8,
            child: Image(
                fit: BoxFit.contain,
                image: AssetImage('assets/images/barber_icon.jpg')),
          ),
        ),
        trailing: GestureDetector(
          onTap: () {
            Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            UposlenikInfoScreen(uposlenik: uposlenik)))
                .then((value) => fetchData());
          },
          child: const Icon(Icons.view_carousel),
        ),
      ),
    );
  }
}
