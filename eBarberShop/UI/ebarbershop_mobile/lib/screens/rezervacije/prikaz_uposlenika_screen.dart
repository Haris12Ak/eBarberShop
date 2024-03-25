import 'package:ebarbershop_mobile/models/search_result.dart';
import 'package:ebarbershop_mobile/models/uposlenik/uposlenik.dart';
import 'package:ebarbershop_mobile/providers/uposlenik_provider.dart';
import 'package:ebarbershop_mobile/screens/rezervacije/uposlenik_info_screen.dart';
import 'package:ebarbershop_mobile/widgets/master_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UposleniciListScreen extends StatefulWidget {
  const UposleniciListScreen({super.key});

  @override
  State<UposleniciListScreen> createState() => _UposleniciListScreenState();
}

class _UposleniciListScreenState extends State<UposleniciListScreen> {
  late UposlenikProvider _uposlenikProvider;
  SearchResult<Uposlenik>? uposleniciResult;
  bool isLoading = true;
  final TextEditingController _imePrezimeController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _uposlenikProvider = context.read<UposlenikProvider>();
    fetchUposlenici();
  }

  Future fetchUposlenici() async {
    uposleniciResult = await _uposlenikProvider.get();
    
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  List<Uposlenik> _filteredUposlenici(String query) {
    return uposleniciResult!.result.where((uposlenik) {
      final fullName = '${uposlenik.ime} ${uposlenik.prezime}'.toLowerCase();
      return fullName.contains(query.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: 'Uposlenici',
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : uposleniciResult!.result.isEmpty
              ? Center(
                  child: Text(
                    'Nema podataka !',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 17.0,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w600),
                  ),
                )
              : Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: TextField(
                        controller: _imePrezimeController,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white24,
                          contentPadding: EdgeInsets.all(0),
                          focusColor: Colors.black,
                          hintText: 'Ime i prezime',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.search),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _imePrezimeController.text = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 18.0),
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) => Divider(
                          height: 30.0,
                          color: Colors.grey.shade400,
                        ),
                        itemCount:
                            _filteredUposlenici(_imePrezimeController.text)
                                .length,
                        itemBuilder: (BuildContext context, int index) {
                          Uposlenik uposlenik = _filteredUposlenici(
                              _imePrezimeController.text)[index];
                          return ListTile(
                            title:
                                Text('${uposlenik.ime} ${uposlenik.prezime}'),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: const Image(
                                  fit: BoxFit.contain,
                                  image: AssetImage(
                                      'assets/images/barber_icon.jpg')),
                            ),
                            trailing: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            UposlenikInfoScreen(
                                                uposlenik: uposlenik)));
                              },
                              child: const Icon(Icons.view_carousel),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }
}
