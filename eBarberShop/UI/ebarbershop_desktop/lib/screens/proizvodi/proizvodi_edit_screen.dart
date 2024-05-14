import 'dart:convert';
import 'dart:io';

import 'package:ebarbershop_desktop/models/proizvodi/proizvodi.dart';
import 'package:ebarbershop_desktop/models/search_result.dart';
import 'package:ebarbershop_desktop/models/validator.dart';
import 'package:ebarbershop_desktop/models/vrsteProizvoda/vrste_proizvoda.dart';
import 'package:ebarbershop_desktop/providers/proizvodi_provider.dart';
import 'package:ebarbershop_desktop/providers/vrste_proizvoda_provider.dart';
import 'package:ebarbershop_desktop/utils/util.dart';
import 'package:ebarbershop_desktop/widgets/master_screen_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ProizvodiEditScreen extends StatefulWidget {
  Proizvodi? proizvod;

  ProizvodiEditScreen({super.key, this.proizvod});

  @override
  State<ProizvodiEditScreen> createState() => _ProizvodiEditScreenState();
}

class _ProizvodiEditScreenState extends State<ProizvodiEditScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late ProizvodiProvider _proizvodiProvider;
  late VrsteProizvodaProvider _vrsteProizvodaProvider;

  SearchResult<VrsteProizvoda>? vrsteProizvodaResult;

  bool isLoading = true;
  bool isSwitchEnabled = true;

  File? _image;
  String? _base64Image;

  String? selectedImageName;

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
  void initState() {
    super.initState();

    _initialValue = {
      'proizvodiId': widget.proizvod?.proizvodiId.toString(),
      'cijena': widget.proizvod?.cijena.toStringAsFixed(2),
      'naziv': widget.proizvod?.naziv,
      'sifra': widget.proizvod?.sifra,
      'opis': widget.proizvod?.opis,
      'slika': widget.proizvod?.slika,
      'status': widget.proizvod?.status,
      'vrstaProizvodaId': widget.proizvod?.vrstaProizvodaId.toString()
    };

    if (widget.proizvod == null) {
      _initialValue['status'] = true;
      isSwitchEnabled = false;
    }

    _proizvodiProvider = context.read<ProizvodiProvider>();
    _vrsteProizvodaProvider = context.read<VrsteProizvodaProvider>();

    getData();
  }

  Future getData() async {
    vrsteProizvodaResult = await _vrsteProizvodaProvider.get();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: widget.proizvod == null ? 'Dodaj proizvod' : 'Detalji proizvoda',
      child: FormBuilder(
        key: _formKey,
        initialValue: _initialValue,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    flex: 1,
                    child: Text(
                      'Naziv proizvoda:',
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
                      name: 'naziv',
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          hintText: 'Naziv proizvoda'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Obavezno polje';
                        }
                        return null;
                      },
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
                      'Šifra:',
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
                      name: 'sifra',
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          hintText: 'Šifra'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Obavezno polje';
                        }
                        return null;
                      },
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
                      'Cijena:',
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
                      name: 'cijena',
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          hintText: 'Cijena'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Obavezno polje';
                        }
                        if (!Validators.validirajCijenu(value)) {
                          return 'Dozvoljen unos samo brojeva!';
                        }
                        return null;
                      },
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
                      'Vrsta proizvoda:',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54),
                    ),
                  ),
                  const SizedBox(width: 30.0),
                  Expanded(
                    flex: 3,
                    child: FormBuilderDropdown<String>(
                      name: 'vrstaProizvodaId',
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintText: 'Vrsta proizvoda',
                        contentPadding:
                            const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                      ),
                      items: vrsteProizvodaResult?.result
                              .map(
                                (item) => DropdownMenuItem(
                                  alignment: AlignmentDirectional.centerStart,
                                  value: item.vrsteProizvodaId.toString(),
                                  child: Text(item.naziv),
                                ),
                              )
                              .toList() ??
                          [],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Obavezno polje';
                        }
                        return null;
                      },
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
                    child: Text(''),
                  ),
                  const SizedBox(width: 30.0),
                  Expanded(
                    flex: 3,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: SizedBox(
                        width: 150,
                        child: FormBuilderSwitch(
                          name: 'status',
                          enabled: isSwitchEnabled,
                          title: const Text(
                            'Status',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54),
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
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

                      if (widget.proizvod != null) {
                        _buildEditProizvod(context, request);
                      } else {
                        _buildAddProizvod(context, request);
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
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _buildAddProizvod(
      BuildContext context, Map<dynamic, dynamic> request) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Potvrda!"),
        content: const Text(
            'Da li ste sigurni da želite dodati proizvod sa unesenim informacijama!'),
        actions: [
          TextButton(
              onPressed: () async {
                try {
                  await _proizvodiProvider
                      .insert(request)
                      .then((value) => Navigator.of(context).pop());

                  if (!context.mounted) {
                    return;
                  }

                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            title: const Text('Poruka!'),
                            content: const Text(
                                'Uspješno ste dodali novi proizvod.'),
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
                  Navigator.of(context).pop();

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
                          child: const Text("Close"),
                        ),
                      ],
                    ),
                  );
                }
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

  Future<dynamic> _buildEditProizvod(
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
                try {
                  await _proizvodiProvider
                      .update(widget.proizvod!.proizvodiId, request)
                      .then((value) => Navigator.of(context).pop());

                  setState(() {
                    _initialValue = Map.from(_formKey.currentState!.value);
                    _initialValue['slika'] = request['slika'];
                  });

                  if (!context.mounted) {
                    return;
                  }

                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            title: const Text('Poruka!'),
                            content: const Text('Proizvod uspješno editovan'),
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
                  Navigator.of(context).pop();

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
                          child: const Text("Close"),
                        ),
                      ],
                    ),
                  );
                }
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
