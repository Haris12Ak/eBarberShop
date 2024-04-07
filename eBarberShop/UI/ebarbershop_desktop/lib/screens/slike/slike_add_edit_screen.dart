import 'dart:convert';
import 'dart:io';

import 'package:ebarbershop_desktop/models/slike/slike.dart';
import 'package:ebarbershop_desktop/providers/slike_provider.dart';
import 'package:ebarbershop_desktop/utils/util.dart';
import 'package:ebarbershop_desktop/widgets/master_screen_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SlikeAddEditScreen extends StatefulWidget {
  Slike? slika;
  SlikeAddEditScreen({super.key, this.slika});

  @override
  State<SlikeAddEditScreen> createState() => _SlikeAddEditScreenState();
}

class _SlikeAddEditScreenState extends State<SlikeAddEditScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late SlikeProvider _slikeProvider;

  String? selectedImageName;
  File? _image;
  String? _base64Image;

  @override
  void initState() {
    super.initState();

    _initialValue = {
      'slikeId': widget.slika?.slikeId,
      'opis': widget.slika?.opis,
      'slika': widget.slika?.slika,
      'datumPostavljanja': widget.slika?.datumPostavljanja,
    };

    _slikeProvider = context.read<SlikeProvider>();
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
    return MasterScreenWidget(
      title: widget.slika == null ? 'Dodaj sliku' : 'Detalji slike',
      child: FormBuilder(
        key: _formKey,
        initialValue: _initialValue,
        child: Container(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.slika != null ? 'Datum objave:' : "",
                    style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54),
                  ),
                  const SizedBox(width: 20.0),
                  Text(
                    widget.slika != null &&
                            _initialValue['datumPostavljanja'] != null &&
                            _initialValue['datumPostavljanja'] != ""
                        ? formatDate(_initialValue['datumPostavljanja'])
                        : "",
                    style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54),
                  ),
                ],
              ),
              if (widget.slika != null)
                const Divider(
                  height: 60.0,
                ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    flex: 1,
                    child: Text(
                      'Opis:',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54),
                    ),
                  ),
                  const SizedBox(width: 30.0),
                  Expanded(
                    flex: 3,
                    child: FormBuilderTextField(
                      name: 'opis',
                      minLines: 6,
                      maxLines: null,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          hintText: 'Opis (opcionalno)'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    flex: 1,
                    child: Text(
                      'Slika:',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54),
                    ),
                  ),
                  const SizedBox(width: 30.0),
                  Expanded(
                    flex: 3,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: 350,
                        height: 400,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.black, width: 1.0)),
                        child: _initialValue['slika'] != "" &&
                                _initialValue['slika'] != null
                            ? imageFromBase64String(_initialValue['slika'])
                            : const Align(
                                alignment: Alignment.center,
                                child: Text('The image does not exist',
                                    textAlign: TextAlign.center)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    flex: 1,
                    child: Text(''),
                  ),
                  const SizedBox(width: 30.0),
                  Expanded(
                    flex: 3,
                    child: FormBuilderField(
                      name: 'slika',
                      builder: ((filed) {
                        return InputDecorator(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10.0),
                            focusColor: Colors.blue,
                            hoverColor: Colors.grey[200],
                            fillColor: Colors.white,
                            filled: true,
                            errorText: filed.errorText,
                          ),
                          child: ListTile(
                            leading: const Icon(Icons.photo),
                            title: Text(selectedImageName ?? "Select Image"),
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
                        if (widget.slika != null) {
                          _buildEditImage(context, request);
                        } else {
                          _buildAddNewImage(context, request);
                        }
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
                                  child: const Text("OK"))
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
    );
  }

  Future<dynamic> _buildEditImage(
      BuildContext context, Map<dynamic, dynamic> request) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Potvrda ažuriranja podataka!"),
        content: const Text(
            'Da li ste sigurni da želite sačuvati trenutne izmjene!'),
        actions: [
          TextButton(
              onPressed: () async {
                await _slikeProvider.update(widget.slika!.slikeId, request);

                setState(() {
                  _initialValue = Map.from(_formKey.currentState!.value);
                  _initialValue['datumPostavljanja'] =
                      DateTime.parse(request['datumPostavljanja']);
                  _initialValue['slika'] = request['slika'];
                });

                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();

                // ignore: use_build_context_synchronously
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: const Text('Poruka!'),
                          content: const Text('Slika uspješno editovana!.'),
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
              },
              child: const Text("Potvrdi")),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Otkaži"))
        ],
      ),
    );
  }

  Future<dynamic> _buildAddNewImage(
      BuildContext context, Map<dynamic, dynamic> request) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Potvrda!"),
        content: const Text('Da li ste sigurni da želite dodati novu sliku!'),
        actions: [
          TextButton(
              onPressed: () async {
                if (_formKey.currentState!.saveAndValidate()) {
                  await _slikeProvider.insert(request);
                }
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();

                // ignore: use_build_context_synchronously
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: const Text('Poruka!'),
                          content:
                              const Text('Uspješno ste dodali novu sliku!.'),
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
              },
              child: const Text("Potvrdi")),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Otkaži"))
        ],
      ),
    );
  }
}
