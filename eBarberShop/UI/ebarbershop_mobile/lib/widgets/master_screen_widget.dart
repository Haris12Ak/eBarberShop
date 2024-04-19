import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MasterScreenWidget extends StatefulWidget {
  String? title;
  Widget child;
  MasterScreenWidget({super.key, this.title, required this.child});

  @override
  State<MasterScreenWidget> createState() => _MasterScreenWidgetState();
}

class _MasterScreenWidgetState extends State<MasterScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[100],
        elevation: 4.0,
        title: Text(
          widget.title ?? "",
          style: const TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.0,
              fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: widget.child,
      ),
    );
  }
}
