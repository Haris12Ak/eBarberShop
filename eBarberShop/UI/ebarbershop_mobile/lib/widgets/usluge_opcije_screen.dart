import 'package:flutter/material.dart';

class UslugeOpcijeScreen extends StatefulWidget {
  final String text;
  final AssetImage image;
  const UslugeOpcijeScreen(
      {super.key, required this.text, required this.image});

  @override
  State<UslugeOpcijeScreen> createState() => _UslugeOpcijeScreenState();
}

class _UslugeOpcijeScreenState extends State<UslugeOpcijeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Image(
            image: widget.image,
            width: 70,
            height: 70,
          ),
          const SizedBox(
            height: 5.0,
          ),
          Text(
            widget.text,
            style: TextStyle(
              fontSize: 23.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
              fontFamily: 'EduNSWACTFoundation',
              letterSpacing: 1.0,
            ),
          )
        ],
      ),
    );
  }
}
