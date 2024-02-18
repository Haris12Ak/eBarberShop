import 'package:ebarbershop_desktop/screens/login_screen.dart';
import 'package:ebarbershop_desktop/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MasterScreen extends StatefulWidget {
  String? title;
  Widget? child;
  String? selectedOption;

  MasterScreen({super.key, this.title, this.child, this.selectedOption});

  @override
  State<MasterScreen> createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(widget.title ?? ""),
        elevation: 0.0,
        backgroundColor: Colors.grey[200],
        actions: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(right: 40.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                        (route) => false,
                      );
                    },
                    tooltip: 'Odjava',
                    icon:
                        Icon(Icons.logout, size: 30.0, color: Colors.grey[900]),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      drawer: DrawerWidget(widget: widget),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
        child: widget.child ?? Container(),
      ),
    );
  }
}
