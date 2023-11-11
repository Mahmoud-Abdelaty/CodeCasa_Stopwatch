import 'package:flutter/material.dart';

class PanelWidget extends StatelessWidget {
  const PanelWidget({super.key, required this.time, required this.text});

  final String time;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(5),
          width: 110,
          height: 120,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.6),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Center(
            child: Text(
              time,
              style: const TextStyle(
                fontSize: 70,
                color: Color.fromARGB(255, 255, 255, 255),
                fontFamily: 'PlaypenSans',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Text(
          text,
          style: const TextStyle(
            fontSize: 23,
            color: Color.fromARGB(255, 0, 0, 0),
            fontFamily: 'Acme',
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
