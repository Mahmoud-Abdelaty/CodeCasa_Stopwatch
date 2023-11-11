import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    required this.icon,
  });

  final String text;
  final Function() onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 65,
          height: 65,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.black,
          ),
          child: IconButton(
            icon: Icon(
              color: const Color.fromARGB(255, 222, 235, 225),
              icon,
              size: 45,
            ),
            onPressed: () {
              onPressed();
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 7),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 22,
              color: Colors.black,
              fontFamily: 'Acme',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
