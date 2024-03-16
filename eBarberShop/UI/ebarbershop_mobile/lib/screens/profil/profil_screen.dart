import 'dart:convert';
import 'dart:io';

import 'package:ebarbershop_mobile/models/korisnik/korisnik.dart';
import 'package:ebarbershop_mobile/models/korisnik/korisnik_update_request.dart';
import 'package:ebarbershop_mobile/providers/korisnik_provider.dart';
import 'package:ebarbershop_mobile/screens/login_screen.dart';
import 'package:ebarbershop_mobile/screens/profil/profil_edit_screen.dart';
import 'package:ebarbershop_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  late KorisnikProvider _korisnikProvider;
  late Korisnik korisnikResult;
  bool isLoading = true;

  File? _image;
  String? _base64Image;

  static final TextStyle _labelStyle = TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: Colors.grey[900]!.withOpacity(0.8));

  static final TextStyle _contentStyle = TextStyle(
      fontSize: 15.0, fontWeight: FontWeight.w500, color: Colors.grey[700]);

  @override
  void initState() {
    super.initState();
    _korisnikProvider = context.read<KorisnikProvider>();

    fetchKorisnik();
  }

  Future fetchKorisnik() async {
    korisnikResult = await _korisnikProvider.getById(Authorization.korisnikId!);

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
        _base64Image = base64Encode(_image!.readAsBytesSync());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 10.0,
            ),
            _buildProfilImage(context),
            const SizedBox(height: 18.0),
            Center(
              child: Text(
                '${korisnikResult.ime} ${korisnikResult.prezime}',
                style: const TextStyle(
                    fontSize: 19.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87),
              ),
            ),
            Divider(
              color: Colors.grey.withOpacity(0.0),
              height: 25.0,
            ),
            Container(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Korisničko ime:',
                        style: _labelStyle,
                      ),
                      Text(
                        korisnikResult.korisnickoIme,
                        style: _contentStyle,
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.grey[400],
                    height: 25.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Email:',
                        style: _labelStyle,
                      ),
                      Text(
                        korisnikResult.email ?? "",
                        style: _contentStyle,
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.grey[400],
                    height: 25.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Kontakt telefon:',
                        style: _labelStyle,
                      ),
                      Text(
                        korisnikResult.brojTelefona ?? "",
                        style: _contentStyle,
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.grey[400],
                    height: 25.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Adresa:',
                        style: _labelStyle,
                      ),
                      Text(
                        korisnikResult.adresa ?? "",
                        style: _contentStyle,
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.grey[400],
                    height: 25.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Mjesto boravka:',
                        style: _labelStyle,
                      ),
                      Text(
                        korisnikResult.gradNaziv ?? "",
                        style: _contentStyle,
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.grey[400],
                    height: 25.0,
                  ),
                ],
              ),
            ),
            _buildEditProfil(context),
            _buildLogOut(context),
          ],
        ),
      );
    }
  }

  ListTile _buildLogOut(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.logout,
        size: 27.0,
      ),
      title: Text(
        'Odjavi se',
        style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[800]),
      ),
      trailing: const Icon(Icons.navigate_next),
      onTap: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const LoginScreen()),
            (route) => false);
      },
    );
  }

  ListTile _buildEditProfil(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.edit_note,
        size: 27.0,
      ),
      title: Text(
        'Uredi profil',
        style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[800]),
      ),
      trailing: const Icon(Icons.navigate_next),
      onTap: () {
        Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        ProfilEditScreen(korisnik: korisnikResult)))
            .then((value) => fetchKorisnik());
      },
    );
  }

  Center _buildProfilImage(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            width: 130,
            height: 130,
            decoration: BoxDecoration(
              color: Colors.grey[350],
              borderRadius: BorderRadius.circular(100),
            ),
            child: korisnikResult.slika != "" && korisnikResult.slika != null
                ? GestureDetector(
                    onTap: () {
                      _deleteProfileImage(context);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image(
                        image: MemoryImage(
                          base64Decode(korisnikResult.slika.toString()),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: const Image(
                      image: AssetImage('assets/images/person_icon.png'),
                    ),
                  ),
          ),
          Positioned(
            bottom: 0.0,
            right: 0.0,
            child: Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.8),
              ),
              child: IconButton(
                onPressed: () async {
                  try {
                    await _getImage();

                    if (_image != null) {
                      KorisnikUpdateRequest request = KorisnikUpdateRequest(
                          korisnikResult.ime,
                          korisnikResult.prezime,
                          korisnikResult.korisnickoIme,
                          korisnikResult.email!,
                          korisnikResult.adresa,
                          korisnikResult.brojTelefona,
                          korisnikResult.status,
                          _base64Image,
                          korisnikResult.gradId,
                          "",
                          "");

                      await _korisnikProvider.update(
                          korisnikResult.korisniciId, request);

                      // ignore: use_build_context_synchronously
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                title: const Text('Poruka'),
                                content: const Text(
                                    'Profilna slika uspješno izmjenjena !.'),
                                actions: [
                                  TextButton(
                                    onPressed: () async {
                                      Navigator.of(context).pop();
                                      var data = await _korisnikProvider
                                          .getById(korisnikResult.korisniciId);

                                      setState(() {
                                        korisnikResult = data;
                                      });
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              ));
                    }
                  } on Exception catch (e) {
                    // ignore: use_build_context_synchronously
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text("Error"),
                        content: Text(e.toString()),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("OK"))
                        ],
                      ),
                    );
                  }
                },
                icon: const Icon(
                  Icons.camera_alt,
                  size: 27.0,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> _deleteProfileImage(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text(
                'Profilna slika',
                textAlign: TextAlign.center,
              ),
              content: Image(
                image: MemoryImage(
                  base64Decode(korisnikResult.slika.toString()),
                ),
                fit: BoxFit.contain,
              ),
              actions: [
                TextButton.icon(
                  onPressed: () async {
                    try {
                      _base64Image = null;

                      KorisnikUpdateRequest request = KorisnikUpdateRequest(
                          korisnikResult.ime,
                          korisnikResult.prezime,
                          korisnikResult.korisnickoIme,
                          korisnikResult.email!,
                          korisnikResult.adresa,
                          korisnikResult.brojTelefona,
                          korisnikResult.status,
                          _base64Image,
                          korisnikResult.gradId,
                          "",
                          "");

                      await _korisnikProvider.update(
                          korisnikResult.korisniciId, request);

                      var data = await _korisnikProvider
                          .getById(korisnikResult.korisniciId);

                      setState(() {
                        korisnikResult = data;
                      });

                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop();
                    } on Exception catch (e) {
                      // ignore: use_build_context_synchronously
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text("Error"),
                          content: Text(e.toString()),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("OK"))
                          ],
                        ),
                      );
                    }
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.grey[400],
                      iconColor: Colors.black),
                  icon: const Icon(Icons.delete_forever),
                  label: const Text(
                    'Ukloni sliku',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey[400],
                  ),
                  child: const Text(
                    'OK',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ));
  }
}
