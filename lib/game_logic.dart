import 'dart:math';

class Player {
  static const x = 'X';
  static const o = 'O';

  static List<int> playerX = [];
  static List<int> playerO = [];
}

extension containAll on List {
  containsAll(int x, int y, [int z]) {
    if (z == null)
      return contains(x) && contains(y);
    else
      return contains(x) && contains(y) && contains(z);
  }
}

class Game {
  void playGame(int index, String activePlayer) {
    if (activePlayer == 'X')
      Player.playerX.add(index);
    else
      Player.playerO.add(index);
  }

  Future<void> autoPlay(activePlayer) async {
    int index = 0;
    List<int> emptyCells = [];
    for (var i = 0; i < 9; i++) {
      if (!(Player.playerX.contains(i) || Player.playerO.contains(i)))
        emptyCells.add(i);
    }

    if (Player.playerX.containsAll(0, 1) && emptyCells.contains(2))
      index = 2;
    else if (Player.playerX.containsAll(3, 4) && emptyCells.contains(5))
      index = 5;
    else if (Player.playerX.containsAll(6, 7) && emptyCells.contains(8))
      index = 8;
    else if (Player.playerX.containsAll(0, 3) && emptyCells.contains(6))
      index = 6;
    else if (Player.playerX.containsAll(1, 4) && emptyCells.contains(7))
      index = 7;
    else if (Player.playerX.containsAll(2, 5) && emptyCells.contains(8))
      index = 8;
    else if (Player.playerX.containsAll(0, 4) && emptyCells.contains(8))
      index = 8;
    else if (Player.playerX.containsAll(2, 4) && emptyCells.contains(6))
      index = 6;
    else if (Player.playerO.containsAll(0, 1) && emptyCells.contains(2))
      index = 2;
    else if (Player.playerO.containsAll(3, 4) && emptyCells.contains(5))
      index = 5;
    else if (Player.playerO.containsAll(6, 7) && emptyCells.contains(8))
      index = 8;
    else if (Player.playerO.containsAll(0, 3) && emptyCells.contains(6))
      index = 6;
    else if (Player.playerO.containsAll(1, 4) && emptyCells.contains(7))
      index = 7;
    else if (Player.playerO.containsAll(2, 5) && emptyCells.contains(8))
      index = 8;
    else if (Player.playerO.containsAll(0, 4) && emptyCells.contains(8))
      index = 8;
    else if (Player.playerO.containsAll(2, 4) && emptyCells.contains(6))
      index = 6;
    else {
      Random random = Random();
      int randomIndex = random.nextInt(emptyCells.length);
      index = emptyCells[randomIndex];
      playGame(index, activePlayer);
    }
  }

  checkWinner() {
    String winner = '';
    if (Player.playerX.containsAll(0, 1, 2) ||
        Player.playerX.containsAll(3, 4, 5) ||
        Player.playerX.containsAll(6, 7, 8) ||
        Player.playerX.containsAll(0, 3, 6) ||
        Player.playerX.containsAll(1, 4, 7) ||
        Player.playerX.containsAll(2, 5, 8) ||
        Player.playerX.containsAll(0, 4, 8) ||
        Player.playerX.containsAll(2, 4, 6))
      winner = 'X';
    else if (Player.playerO.containsAll(0, 1, 2) ||
        Player.playerO.containsAll(3, 4, 5) ||
        Player.playerO.containsAll(6, 7, 8) ||
        Player.playerO.containsAll(0, 3, 6) ||
        Player.playerO.containsAll(1, 4, 7) ||
        Player.playerO.containsAll(2, 5, 8) ||
        Player.playerO.containsAll(0, 4, 8) ||
        Player.playerO.containsAll(2, 4, 6))
      winner = 'O';
    else
      winner = '';
    return winner;
  }
}
