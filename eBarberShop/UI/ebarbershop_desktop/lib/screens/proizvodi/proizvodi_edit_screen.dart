import 'dart:convert';
import 'dart:io';

import 'package:ebarbershop_desktop/models/proizvodi/proizvodi.dart';
import 'package:ebarbershop_desktop/models/search_result.dart';
import 'package:ebarbershop_desktop/models/vrsteProizvoda/vrste_proizvoda.dart';
import 'package:ebarbershop_desktop/providers/proizvodi_provider.dart';
import 'package:ebarbershop_desktop/providers/vrste_proizvoda_provider.dart';
import 'package:ebarbershop_desktop/utils/util.dart';
import 'package:ebarbershop_desktop/widgets/button_back_widget.dart';
import 'package:ebarbershop_desktop/widgets/master_screen.dart';
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
    return MasterScreen(
      title: widget.proizvod == null ? 'Dodaj proizvod' : 'Detalji proizvoda',
      child: isLoading
          ? Container()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                )
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
            children: [
              Expanded(
                child: FormBuilderTextField(
                  name: 'naziv',
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.0),
                      gapPadding: 5.0,
                    ),
                    focusColor: Colors.blue,
                    hoverColor: Colors.grey[200],
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'Naziv proizvoda',
                    floatingLabelStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 100.0,
              ),
              Expanded(
                child: FormBuilderTextField(
                  name: 'cijena',
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.0),
                      gapPadding: 5.0,
                    ),
                    focusColor: Colors.blue,
                    hoverColor: Colors.grey[200],
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'Cijena',
                    floatingLabelStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          Row(
            children: [
              Expanded(
                child: FormBuilderTextField(
                  name: 'sifra',
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.0),
                      gapPadding: 5.0,
                    ),
                    focusColor: Colors.blue,
                    hoverColor: Colors.grey[200],
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'Šifra',
                    floatingLabelStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 100.0,
              ),
              Expanded(
                child: FormBuilderDropdown<String>(
                  name: 'vrstaProizvodaId',
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.0),
                      gapPadding: 5.0,
                    ),
                    focusColor: Colors.blue,
                    hoverColor: Colors.grey[200],
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'Vrsta proizvoda',
                    floatingLabelStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
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
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
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
                    const SizedBox(height: 25.0),
                    Align(
                      alignment: Alignment.topLeft,
                      child: SizedBox(
                        width: 150,
                        child: FormBuilderSwitch(
                          name: 'status',
                          title: const Text(
                            'Status',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
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
            
                try {
                  if (widget.proizvod != null) {
                    _buildEditProizvod(context, request);
                  } else {
                    _buildAddProizvod(context, request);
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
          )
        ],
      ),
    );
  }

  Future<dynamic> _buildAddProizvod(
      BuildContext context, Map<dynamic, dynamic> request) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Potvrda!"),
        content: const Text(
            'Da li ste sigurni da želite dodati proizvod sa unesenim informacijama!'),
        actions: [
          TextButton(
              onPressed: () async {
                if (_formKey.currentState!.saveAndValidate()) {
                  await _proizvodiProvider.insert(request);
                }
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();

                // ignore: use_build_context_synchronously
                showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: const Text('Poruka!'),
                          content:
                              const Text('Uspješno ste dodali novi proizvod.'),
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

  Future<dynamic> _buildEditProizvod(
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
                await _proizvodiProvider.update(
                    widget.proizvod!.proizvodiId, request);
                setState(() {
                  _initialValue = Map.from(_formKey.currentState!.value);
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
}
