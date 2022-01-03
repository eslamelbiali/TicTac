import 'package:flutter/material.dart';

import 'game_logic.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String activePlayer = 'X';
  int turn = 0;
  String result = '';
  bool gameOver = false;
  Game game = Game();
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            SwitchListTile.adaptive(
              title: Text(
                'Turn on / off two player',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                ),
                textAlign: TextAlign.center,
              ),
              value: isSwitched,
              onChanged: (bool newValue) {
                setState(() {
                  isSwitched = newValue;
                });
              },
            ),
            Text(
              'It \'s $activePlayer Turn'.toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 42,
              ),
              textAlign: TextAlign.center,
            ),
            Expanded(
                child: GridView.count(
              padding: EdgeInsets.all(16.0),
              crossAxisCount: 3,
              childAspectRatio: 1.0,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              children: List.generate(
                  9,
                  (index) => InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: gameOver ? null : () => _onTap(index),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Theme.of(context).shadowColor),
                          child: Center(
                              child: Text(
                            Player.playerX.contains(index)
                                ? 'X'
                                : Player.playerO.contains(index)
                                    ? 'O'
                                    : '',
                            style: TextStyle(
                              color: Player.playerX.contains(index)
                                  ? Colors.blue
                                  : Colors.pink,
                              fontSize: 42,
                            ),
                          )),
                        ),
                      )),
            )),
            Text(
              result,
              style: TextStyle(
                color: Colors.white,
                fontSize: 42,
              ),
              textAlign: TextAlign.center,
            ),
            ElevatedButton.icon(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Theme.of(context).splashColor)),
              onPressed: () {
                setState(() {
                  Player.playerO = [];
                  Player.playerX = [];
                  activePlayer = 'X';
                  turn = 0;
                  result = '';
                  gameOver = false;
                  game = Game();
                });
              },
              icon: Icon(Icons.replay),
              label: Text('repeat the game'),
            ),
          ],
        ),
      ),
    );
  }

  _onTap(int index) async {
    if ((Player.playerX.isEmpty || !Player.playerX.contains(index)) &&
        (Player.playerO.isEmpty || !Player.playerO.contains(index))) {
      game.playGame(index, activePlayer);
      updateGame();
      if (!isSwitched && !gameOver) {
        await game.autoPlay(activePlayer);
        updateGame();
      }
    }
  }

  void updateGame() {
    setState(() {
      activePlayer = (activePlayer == 'X') ? 'O' : 'X';
      turn++;
      String winnerPlayer = game.checkWinner();
      if (winnerPlayer != '') {
        gameOver = true;
        result = '$winnerPlayer is the winner';
      } else if (!gameOver && turn == 9) result = 'It\'s draw';
    });
  }
}
