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
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          widget.title ?? "",
          style: const TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.0,
              color: Colors.black54,
              fontStyle: FontStyle.italic),
        ),
        elevation: 0.0,
        backgroundColor: Colors.grey[300],
      ),
      body: Container(
        color: Colors.white,
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(150.0, 15.0, 150.0, 15.0),
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: widget.child,
        ),
      ),
    );
  }
}
