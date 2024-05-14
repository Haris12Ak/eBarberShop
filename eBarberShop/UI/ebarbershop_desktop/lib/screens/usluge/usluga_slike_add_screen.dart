import 'dart:convert';
import 'dart:io';

import 'package:ebarbershop_desktop/models/slike/slike.dart';
import 'package:ebarbershop_desktop/providers/slike_provider.dart';
import 'package:ebarbershop_desktop/providers/slike_usluge_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class UslugaSlikeAddScreen extends StatefulWidget {
  String uslugaNaziv;
  int uslugaId;
  UslugaSlikeAddScreen(
      {super.key, required this.uslugaNaziv, required this.uslugaId});

  @override
  State<UslugaSlikeAddScreen> createState() => _UslugaSlikeAddScreenState();
}

class _UslugaSlikeAddScreenState extends State<UslugaSlikeAddScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final Map<String, dynamic> _initialValue = {};

  late SlikeProvider _slikeProvider;
  late SlikeUslugeProvider _slikeUslugeProvider;

  String? selectedImageName;
  File? _image;
  String? _base64Image;

  @override
  void initState() {
    super.initState();

    _slikeProvider = context.read<SlikeProvider>();
    _slikeUslugeProvider = context.read<SlikeUslugeProvider>();
  }

  Future getImage() async {
    var result = await FilePicker.platform.pickFiles(type: FileType.image);

    setState(() {
      selectedImageName = result?.files.single.name;
    });

    if (result != null && result.files.single.path != null) {
      _image = File(result.files.single.path!);
      _base64Image = base64Encode(_image!.readAsBytesSync());

      setState(() {
        _initialValue['slika'] = _base64Image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Dodaj sliku za uslugu: ${widget.uslugaNaziv}',
          style: const TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.0,
              color: Colors.black54,
              fontStyle: FontStyle.italic),
        ),
        elevation: 0.0,
        backgroundColor: Colors.grey[100],
      ),
      body: FormBuilder(
        key: _formKey,
        initialValue: _initialValue,
        child: SingleChildScrollView(
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 50.0, horizontal: 100.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: FormBuilderTextField(
                        name: 'opis',
                        minLines: 10,
                        maxLines: null,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white30,
                            contentPadding: const EdgeInsets.all(10.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            hintText: 'Opis (opcionalno)'),
                      ),
                    ),
                    const SizedBox(width: 100.0),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              width: 400,
                              height: 500,
                              decoration: BoxDecoration(
                                  color: Colors.white30,
                                  border: Border.all(
                                      color: Colors.black, width: 1.0)),
                              child: _initialValue['slika'] != "" &&
                                      _initialValue['slika'] != null
                                  ? Image(
                                      fit: BoxFit.contain,
                                      image: MemoryImage(
                                        base64Decode(
                                          _initialValue['slika'],
                                        ),
                                      ),
                                    )
                                  : const Align(
                                      alignment: Alignment.center,
                                      child: Text('The image does not exist',
                                          textAlign: TextAlign.center)),
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          FormBuilderField(
                            name: 'slika',
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            builder: ((filed) {
                              return InputDecorator(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white30,
                                  contentPadding: const EdgeInsets.all(10.0),
                                  errorText: filed.errorText,
                                ),
                                child: ListTile(
                                  leading: const Icon(Icons.photo),
                                  title:
                                      Text(selectedImageName ?? "Select Image"),
                                  trailing: const Icon(Icons.file_upload),
                                  onTap: getImage,
                                ),
                              );
                            }),
                            validator: (value) {
                              if (selectedImageName == null ||
                                  selectedImageName!.isEmpty) {
                                return 'Unos slike obavezan !';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30.0),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      if (_formKey.currentState!.saveAndValidate()) {
                        var request = Map.from(_formKey.currentState!.value);

                        if (_base64Image != null && _base64Image != "") {
                          request['slika'] = _base64Image;
                        }

                        request['datumPostavljanja'] =
                            DateTime.now().toIso8601String();

                        try {
                          Slike slika = await _slikeProvider.insert(request);

                          var newSlikaUsluge = {
                            'uslugaId': widget.uslugaId,
                            'slikaId': slika.slikeId
                          };

                          await _slikeUslugeProvider.insert(newSlikaUsluge);

                          if (!context.mounted) {
                            return;
                          }

                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    title: const Text('Poruka!'),
                                    content:
                                        const Text('Slika uspješno dodana!.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          _formKey.currentState?.reset();

                                          Navigator.of(context).pop();

                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ));
                        } on Exception catch (e) {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text("Error"),
                              content: Text(e.toString()),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();

                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Close"))
                              ],
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            showCloseIcon: true,
                            content: Text("Unesite ispravno podatke !."),
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.save_alt),
                    label: const Text(
                      'Spremi',
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
