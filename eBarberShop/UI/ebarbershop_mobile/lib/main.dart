import 'package:ebarbershop_mobile/providers/cart_provider.dart';
import 'package:ebarbershop_mobile/providers/grad_provider.dart';
import 'package:ebarbershop_mobile/providers/korisnik_provider.dart';
import 'package:ebarbershop_mobile/providers/login_provider.dart';
import 'package:ebarbershop_mobile/providers/narudzbe_detalji_provider.dart';
import 'package:ebarbershop_mobile/providers/narudzbe_provider.dart';
import 'package:ebarbershop_mobile/providers/novosti_provider.dart';
import 'package:ebarbershop_mobile/providers/ocjene_provider.dart';
import 'package:ebarbershop_mobile/providers/payment_detail_provider.dart';
import 'package:ebarbershop_mobile/providers/proizvodi_provider.dart';
import 'package:ebarbershop_mobile/providers/recenzije_provider.dart';
import 'package:ebarbershop_mobile/providers/recommend_provider.dart';
import 'package:ebarbershop_mobile/providers/rezervacija_provider.dart';
import 'package:ebarbershop_mobile/providers/slike_provider.dart';
import 'package:ebarbershop_mobile/providers/slike_usluge_provider.dart';
import 'package:ebarbershop_mobile/providers/termini_provider.dart';
import 'package:ebarbershop_mobile/providers/uposlenik_provider.dart';
import 'package:ebarbershop_mobile/providers/usluga_provider.dart';
import 'package:ebarbershop_mobile/providers/vrste_proizvoda_provider.dart';
import 'package:ebarbershop_mobile/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => LoginProvider()),
      ChangeNotifierProvider(create: (_) => NovostiProvider()),
      ChangeNotifierProvider(create: (_) => SlikeProvider()),
      ChangeNotifierProvider(create: (_) => RecenzijeProvider()),
      ChangeNotifierProvider(create: (_) => KorisnikProvider()),
      ChangeNotifierProvider(create: (_) => GradProvider()),
      ChangeNotifierProvider(create: (_) => UslugaProvider()),
      ChangeNotifierProvider(create: (_) => RezervacijaProvider()),
      ChangeNotifierProvider(create: (_) => TerminiProvider()),
      ChangeNotifierProvider(create: (_) => UposlenikProvider()),
      ChangeNotifierProvider(create: (_) => SlikeUslugeProvider()),
      ChangeNotifierProvider(create: (_) => OcjeneProvider()),
      ChangeNotifierProvider(create: (_) => ProizvodiProvider()),
      ChangeNotifierProvider(create: (_) => CartProvider()),
      ChangeNotifierProvider(create: (_) => NarudzbeProvider()),
      ChangeNotifierProvider(create: (_) => NarudzbeDetaljiProvider()),
      ChangeNotifierProvider(create: (_) => VrsteProizvodaProvider()),
      ChangeNotifierProvider(create: (_) => RecommendProvider()),
      ChangeNotifierProvider(create: (_) => PaymentDetailProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
