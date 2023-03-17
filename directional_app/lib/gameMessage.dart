import 'package:flutter/material.dart';

class GameMessage extends StatelessWidget {
  String message;
  GameMessage(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 30),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }
}
