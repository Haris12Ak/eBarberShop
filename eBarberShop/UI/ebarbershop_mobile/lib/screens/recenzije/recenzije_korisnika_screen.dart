import 'package:ebarbershop_mobile/models/recenzije/recenzije.dart';
import 'package:ebarbershop_mobile/models/search_result.dart';
import 'package:ebarbershop_mobile/providers/recenzije_provider.dart';
import 'package:ebarbershop_mobile/screens/recenzije/recenzije_edit_screen.dart';
import 'package:ebarbershop_mobile/utils/util.dart';
import 'package:ebarbershop_mobile/widgets/master_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecenzijeKorisnikaScreen extends StatefulWidget {
  const RecenzijeKorisnikaScreen({super.key});

  @override
  State<RecenzijeKorisnikaScreen> createState() =>
      _RecenzijeKorisnikaScreenState();
}

class _RecenzijeKorisnikaScreenState extends State<RecenzijeKorisnikaScreen> {
  late RecenzijeProvider _recenzijeProvider;
  SearchResult<Recenzije>? recenzijeResult;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();

    _recenzijeProvider = context.read<RecenzijeProvider>();
    fetchRecenzijeByKorisnikId();
  }

  Future fetchRecenzijeByKorisnikId() async {
    recenzijeResult = await _recenzijeProvider.GetRecenzijeByKorisnikId(
        Authorization.korisnikId!);

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
        title: 'Moje recenzije',
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : recenzijeResult!.result.isEmpty
                ? Center(
                    child: Text(
                      'Nemate recenzija !',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w600),
                    ),
                  )
                : ListView.builder(
                    itemCount: recenzijeResult!.result.length,
                    itemBuilder: (BuildContext context, int index) {
                      Recenzije recenzija = recenzijeResult!.result[index];
                      return Column(
                        children: [
                          ListTile(
                              title: Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(recenzija.ocjena.toString())
                                ],
                              ),
                              subtitle: Text(
                                recenzija.sadrzaj,
                                textAlign: TextAlign.left,
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  RecenzijeEditScreen(
                                                      recenzija:
                                                          recenzija))).then(
                                          (value) =>
                                              fetchRecenzijeByKorisnikId());
                                    },
                                    icon: const Icon(Icons.edit),
                                  ),
                                  _buildDelete(recenzija, context),
                                ],
                              )),
                          const Divider(
                            color: Colors.black,
                            height: 10.0,
                          )
                        ],
                      );
                    }));
  }

  IconButton _buildDelete(Recenzije recenzija, BuildContext context) {
    return IconButton(
      onPressed: () async {
        try {
          await _recenzijeProvider.delete(recenzija.recenzijeId);

          // ignore: use_build_context_synchronously
          showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                    title: const Text('Poruka'),
                    content: const Text('Recenzija uspješno obrisana!.'),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          setState(() {
                            fetchRecenzijeByKorisnikId();
                          });

                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ));
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
      icon: const Icon(Icons.delete_forever),
    );
  }
}
