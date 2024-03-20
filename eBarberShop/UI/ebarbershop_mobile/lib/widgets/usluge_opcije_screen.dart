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
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomLeft,
          colors: [
            Colors.black26,
            Colors.white30,
          ],
        ),
      ),
      width: double.infinity,
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
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.grey[700]),
          )
        ],
      ),
    );
  }
}
