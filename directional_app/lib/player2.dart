import 'package:flutter/material.dart';

class PlayerTwoDisplay extends StatelessWidget {
  bool isMyTurn;
  PlayerTwoDisplay(this.isMyTurn, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Text(
        "Player 2 (X)",
        style: TextStyle(
          fontSize: 18,
          color: isMyTurn ? Colors.amberAccent : Colors.white,
          fontWeight: isMyTurn ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
