import 'package:flutter/material.dart';

class PlayerOneDisplay extends StatelessWidget {
  bool isMyTurn = true;
  PlayerOneDisplay(this.isMyTurn, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Text(
        isMyTurn ? "Player 1 (O) 차례" : "Player 1 (O)",
        style: TextStyle(
          fontSize: 18,
          color: isMyTurn ? Colors.amberAccent : Colors.white,
          fontWeight: isMyTurn ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
