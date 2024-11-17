import 'package:flutter/material.dart';

void main() {
  runApp(TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TicTacToe(),
    );
  }
}

class TicTacToe extends StatefulWidget {
  @override
  _TicTacToeState createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  late List<List<String>> _board;
  late String _currentPlayer;
  String? _winner;

  @override
  void initState() {
    super.initState();
    _initializeBoard();
  }

  void _initializeBoard() {
    _board = List.generate(3, (i) => List.filled(3, ''));
    _currentPlayer = 'X';
    _winner = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      body: _buildGameBoard(),
    );
  }

  Widget _buildGameBoard() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStatus(),
        SizedBox(height: 20),
        _buildGrid(),
        SizedBox(height: 20),
        _buildResetButton(),
      ],
    );
  }

  Widget _buildStatus() {
    if (_winner != null) {
      return Text('Winner: $_winner!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold));
    } else {
      return Text('Current Player: $_currentPlayer', style: TextStyle(fontSize: 18));
    }
  }

  Widget _buildGrid() {
    return Column(
      children: List.generate(3, (row) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (col) {
            return _buildSquare(row, col);
          }),
        );
      }),
    );
  }

  Widget _buildSquare(int row, int col) {
    return GestureDetector(
      onTap: () => _onSquareTapped(row, col),
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: Center(
          child: Text(
            _board[row][col],
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildResetButton() {
    return ElevatedButton(
      onPressed: _resetGame,
      child: Text('Reset Game'),
    );
  }

  void _onSquareTapped(int row, int col) {
    if (_board[row][col] == '' && _winner == null) {
      setState(() {
        _board[row][col] = _currentPlayer;
        if (_checkWinner(row, col)) {
          _winner = _currentPlayer;
        } else {
          _currentPlayer = (_currentPlayer == 'X') ? 'O' : 'X';
        }
      });
    }
  }

  bool _checkWinner(int row, int col) {
    // Check row
    if (_board[row][0] == _currentPlayer && _board[row][1] == _currentPlayer && _board[row][2] == _currentPlayer) {
      return true;
    }
    // Check column
    if (_board[0][col] == _currentPlayer && _board[1][col] == _currentPlayer && _board[2][col] == _currentPlayer) {
      return true;
    }
    // Check diagonals
    if ((row == col || row + col == 2) &&
        ((_board[0][0] == _currentPlayer && _board[1][1] == _currentPlayer && _board[2][2] == _currentPlayer) ||
            (_board[0][2] == _currentPlayer && _board[1][1] == _currentPlayer && _board[2][0] == _currentPlayer))) {
      return true;
    }
    return false;
  }

  void _resetGame() {
    setState(() {
      _initializeBoard();
    });
  }
}
