import 'package:flutter/material.dart';

class ButtonBackWidget extends StatelessWidget {
  const ButtonBackWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(
          Icons.arrow_back,
          color: Colors.blue[800],
        ),
        label: Text(
          'Nazad',
          style: TextStyle(fontSize: 16.0, color: Colors.blue[800]),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[100],
          elevation: 0.0,
          foregroundColor: Colors.blueGrey,
          minimumSize: const Size(100, 50),
          padding: const EdgeInsets.fromLTRB(0.0, 5.0, 15.0, 5.0),
        ),
      ),
    );
  }
}
