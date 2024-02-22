import 'dart:convert';
import 'dart:io';

import 'package:ebarbershop_desktop/models/slike/slike.dart';
import 'package:ebarbershop_desktop/providers/slike_provider.dart';
import 'package:ebarbershop_desktop/utils/util.dart';
import 'package:ebarbershop_desktop/widgets/button_back_widget.dart';
import 'package:ebarbershop_desktop/widgets/master_screen.dart';
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
    return MasterScreen(
      title: widget.slika == null ? 'Dodaj sliku' : 'Detalji slike',
      child: Column(
        children: [
          const ButtonBackWidget(),
          const SizedBox(
            height: 15.0,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(15.0),
                child: _buildForm(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  FormBuilder _buildForm(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      initialValue: _initialValue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Opis',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    FormBuilderTextField(
                      name: 'opis',
                      minLines: 9,
                      maxLines: null,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0.0),
                          gapPadding: 5.0,
                        ),
                        focusColor: Colors.blue,
                        hoverColor: Colors.grey[200],
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                    const Divider(
                      height: 100.0,
                      color: Colors.grey,
                    ),
                    Text(
                      widget.slika != null ? 'Datum objave:' : "",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      widget.slika != null &&
                              _initialValue['datumPostavljanja'] != null &&
                              _initialValue['datumPostavljanja'] != ""
                          ? formatDate(_initialValue['datumPostavljanja'])
                          : "",
                      style: const TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 100.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Slika',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Align(
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
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text(
                      'Odaberite sliku',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 3.0,
                    ),
                    FormBuilderField(
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
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50.0,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton.icon(
              onPressed: () async {
                _formKey.currentState?.saveAndValidate();

                var request = Map.from(_formKey.currentState!.value);

                if (_base64Image != null && _base64Image != "") {
                  request['slika'] = _base64Image;
                }

                request['datumPostavljanja'] = DateTime.now().toIso8601String();

                try {
                  if (widget.slika != null) {
                    _buildEditImage(context, request);
                  } else {
                    _buildAddNewImage(context, request);
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
    );
  }

  Future<dynamic> _buildEditImage(
      BuildContext context, Map<dynamic, dynamic> request) {
    return showDialog(
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
