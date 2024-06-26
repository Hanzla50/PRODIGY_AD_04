import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: TicTacToeGame(),
  ));
}

class TicTacToeGame extends StatefulWidget {
  const TicTacToeGame({super.key});

  @override
  _TicTacToeGameState createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  List<String> _board = List.filled(9, '');
  bool _xTurn = true;
  String _result = '';

  void _handleTap(int index) {
    if (_board[index] == '' && _result == '') {
      setState(() {
        _board[index] = _xTurn ? 'X' : 'O';
        _xTurn = !_xTurn;
        _checkWinner();
      });
    }
  }

  void _checkWinner() {
    const List<List<int>> _winningCombinations = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var combo in _winningCombinations) {
      if (_board[combo[0]] != '' &&
          _board[combo[0]] == _board[combo[1]] &&
          _board[combo[1]] == _board[combo[2]]) {
        setState(() {
          _result = '${_board[combo[0]]} wins!';
        });
        return;
      }
    }

    if (!_board.contains('')) {
      setState(() {
        _result = 'Draw!';
      });
    }
  }

  void _resetGame() {
    setState(() {
      _board = List.filled(9, '');
      _xTurn = true;
      _result = '';
    });
  }

  void _showResetDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Reset Game'),
          content: const Text('Are you sure you want to reset the game?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _resetGame();
                Navigator.of(context).pop();
              },
              child: const Text('Reset'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TICTACTOE GAME'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _result.isEmpty
                ? 'Turn: ${_xTurn ? 'X' : 'O'}'
                : _result,
            style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            ),
            itemCount: 9,
            shrinkWrap: true,
            padding: const EdgeInsets.all(16.0),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _handleTap(index),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    color: Colors.grey[300],
                  ),
                  child: Center(
                    child: Text(
                      _board[index],
                      style: const TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _showResetDialog,
            child: const Text('Reset Game'),
          ),
        ],
      ),
    );
  }
}
