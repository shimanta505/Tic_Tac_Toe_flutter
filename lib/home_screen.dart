import 'package:flutter/material.dart';
import 'package:flutter_tic_tac_toe/widget/gameBox.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool playerX = true;
  List<String> selectedIndex = ['', '', '', '', '', '', '', '', ''];
  var gameOver = false;
  int clicked = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Game board")),
      ),
      body: Column(
        children: [
          _playerScreen(),
          _tictacgameBoard(),
          _resultScreen(),
        ],
      ),
    );
  }

  _playerScreen() {
    return Expanded(
        flex: 2,
        child: Container(
          color: Colors.green,
          width: Get.width,
          child: Center(
            child: playerX
                ? Text(
                    "player X your turn",
                    style: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500),
                  )
                : Text(
                    "player O your turn",
                    style: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500),
                  ),
          ),
        ));
  }

  _tictacgameBoard() {
    return Expanded(
      flex: 6,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemCount: 9,
          itemBuilder: ((context, index) {
            return InkWell(
              onTap: () => !gameOver ? insertPlayer(index) : null,
              child: GameBox(
                playerName: selectedIndex[index],
              ),
            );
          }),
        ),
      ),
    );
  }

  checkWinner(String selected) {
    if (selectedIndex[0] == selected &&
        selectedIndex[1] == selected &&
        selectedIndex[2] == selected) {
      gameOver = true;
    } else if (selectedIndex[3] == selected &&
        selectedIndex[4] == selected &&
        selectedIndex[5] == selected) {
      gameOver = true;
    } else if (selectedIndex[6] == selected &&
        selectedIndex[7] == selected &&
        selectedIndex[8] == selected) {
      gameOver = true;
    } else if (selectedIndex[0] == selected &&
        selectedIndex[4] == selected &&
        selectedIndex[8] == selected) {
      gameOver = true;
    } else if (selectedIndex[2] == selected &&
        selectedIndex[4] == selected &&
        selectedIndex[6] == selected) {
      gameOver = true;
    } else if (clicked == 9) {
      print("game over");
    }
  }

  void insertPlayer(int index) {
    print('clicked');
    if (playerX && selectedIndex[index] == '') {
      setState(() {
        selectedIndex[index] = "X";
        playerX = !playerX;
        clicked++;
        checkWinner('X');
      });
    } else if (playerX == false && selectedIndex[index] == '') {
      setState(() {
        selectedIndex[index] = "O";
        playerX = !playerX;
        clicked++;
        checkWinner("O");
      });
    }
  }

  _resultScreen() {
    return Expanded(flex: 2, child: gameOver ? _gameOver() : Container());
  }

  _gameOver() {
    var winner = !playerX ? "X" : "O";
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              "the winner is $winner",
              style: TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () => _playAgain(),
              child: Container(
                  width: 100, child: Center(child: Text("play again"))))
        ],
      ),
    );
  }

  _playAgain() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        selectedIndex[i] = '';
      }
      gameOver = false;
    });
  }
}
