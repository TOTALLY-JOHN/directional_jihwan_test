import 'dart:math';

import 'package:directional_app/gameMessage.dart';
import 'package:directional_app/gameTitle.dart';
import 'package:directional_app/player1.dart';
import 'package:directional_app/player2.dart';
import 'package:flutter/material.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  bool _isPlay = false;
  bool _playerOneTurn = false;
  int _touchedX = 0, _touchedY = 0;

  List<List<String>> board = List.generate(
      3, (i) => List.generate(3, (i) => "", growable: false),
      growable: false);

  @override
  void initState() {
    super.initState();

    print(board);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                Colors.blue[400] as Color,
                Colors.blue[600] as Color,
                Colors.blue[800] as Color,
              ],
            ),
          ),
          alignment: Alignment.center,
          child: Stack(
            children: [
              playerDisplayContainer(_playerOneTurn),
              gameGridBoard(),
              Visibility(
                visible: !_isPlay,
                child: menuButton(),
              ),
              Visibility(
                  visible: _isPlay,
                  child: GameMessage(_playerOneTurn
                      ? "플레이어 1의 차례입니다.\n비어 있는 박스를 터치해주세요."
                      : "플레이어 2의 차례입니다.\n비어 있는 박스를 터치해주세요.")),
            ],
          ),
        ),
      ),
    );
  }

  Widget playerDisplayContainer(bool isPlayerOneTurn) {
    return Container(
      margin: const EdgeInsets.only(top: 70),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PlayerOneDisplay(isPlayerOneTurn),
          PlayerTwoDisplay(!isPlayerOneTurn)
        ],
      ),
    );
  }

  Widget gameGridBoard() {
    late List<Widget> boxes = [];
    for (var i = 1; i <= 3; i++) {
      for (var j = 1; j <= 3; j++) {
        boxes.add(boardBox(i, j, mark: board[i - 1][j - 1]));
      }
    }
    return Center(
      child: GridView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        children: boxes,
      ),
    );
  }

  Widget boardBox(int x, int y, {String mark = ""}) {
    return GestureDetector(
      onTap: () {
        // 판이 비어 있을 때
        if (board[x - 1][y - 1] == "") {
          setState(() {
            _playerOneTurn
                ? board[x - 1][y - 1] = "O"
                : board[x - 1][y - 1] = "X";
            _playerOneTurn = !_playerOneTurn;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("비어 있는 곳만 표시가 가능합니다")));
        }
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        color: Colors.white70,
        alignment: Alignment.center,
        child: Text(
          mark,
          style: const TextStyle(fontSize: 48),
        ),
      ),
    );
  }

  Widget menuButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.black54,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const GameTitle(),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () => setState(() {
              // 첫 시작 랜덤 정하기
              _isPlay = true;
              int whoPlaysFirst = Random().nextInt(2);
              _playerOneTurn = whoPlaysFirst == 0 ? true : false;
            }),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              child: const Text(
                "게임 시작",
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              child: const Text(
                "게임 종료",
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
