import 'package:ebarbershop_desktop/models/proizvodi/proizvodi.dart';
import 'package:ebarbershop_desktop/models/search_result.dart';
import 'package:ebarbershop_desktop/models/vrsteProizvoda/vrste_proizvoda.dart';
import 'package:ebarbershop_desktop/providers/proizvodi_provider.dart';
import 'package:ebarbershop_desktop/providers/vrste_proizvoda_provider.dart';
import 'package:ebarbershop_desktop/widgets/button_back_widget.dart';
import 'package:ebarbershop_desktop/widgets/master_screen.dart';
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
      title: 'Detalji proizvoda',
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
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(15.0),
                    child: FormBuilder(
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
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        10.0, 5.0, 10.0, 5.0),
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
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 550),
                                  child: FormBuilderTextField(
                                    name: 'cijena',
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          10.0, 5.0, 10.0, 5.0),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(0.0),
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
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        10.0, 5.0, 10.0, 5.0),
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
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 200),
                                  child: FormBuilderDropdown<String>(
                                    name: 'vrstaProizvodaId',
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          10.0, 5.0, 10.0, 5.0),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(0.0),
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
                                                alignment: AlignmentDirectional
                                                    .centerStart,
                                                value: item.vrsteProizvodaId
                                                    .toString(),
                                                child: Text(item.naziv),
                                              ),
                                            )
                                            .toList() ??
                                        [],
                                  ),
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
                                      minLines: 8,
                                      maxLines: null,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.all(10.0),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(0.0),
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
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 700),
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
                            ],
                          ),
                          const SizedBox(
                            height: 50.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () async {
                                  _formKey.currentState?.saveAndValidate();

                                  var request =
                                      Map.from(_formKey.currentState!.value);

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
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: const Text("Error"),
                                        content: Text(e.toString()),
                                        actions: [
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
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
                            ],
                          )
                        ],
                      ),
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
