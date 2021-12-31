import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/models/letter_state.dart';
import 'package:wordle/widgets/wordle.dart';

class GameLetter extends StatelessWidget {
  final int col;
  final int row;
  bool isSubmitted = false;
  String _letter = '';
  LetterState _letterState = LetterState.unknown;

  GameLetter(this.col, this.row, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var game = context.watch<Wordle>();

    if (game.guesses.length > col && game.guesses[col].length > row) {
      _letter = game.guesses[col][row];
    } else {
      _letter = '';
    }

    if (game.currentGuess > col && _letter != '' ||
        game.isWon && game.currentGuess == col) {
      // only display letter state for old guesses
      // or if game is won
      _letterState = game.guessLetterStates[col][row];
    }

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: _getBorderColor(),
            width: isSubmitted ? 0 : 2,
          ),
          color: _getBackgroundColor(),
        ),
        width: 50.0,
        height: 50.0,
        child: Center(
          child: Text(
            _letter,
            style: _getTextStyle(),
          ),
        ),
      ),
    );
  }

  Color _getBorderColor() {
    var bg = _getBackgroundColor();
    if (bg != Colors.transparent) {
      return bg;
    }

    if (_letter.isNotEmpty) {
      return Colors.grey.shade600;
    }
    return Colors.grey.shade300;
  }

  TextStyle _getTextStyle() {
    if (_letterState == LetterState.notInWord) {
      return TextStyle(
        fontSize: 30.0,
        color: Colors.white,
        backgroundColor: _getBackgroundColor(),
      );
    } else if (_letterState == LetterState.wrongSpot) {
      return TextStyle(
        fontSize: 30.0,
        color: Colors.white,
        backgroundColor: _getBackgroundColor(),
      );
    } else if (_letterState == LetterState.correctSpot) {
      return TextStyle(
        fontSize: 30.0,
        color: Colors.white,
        backgroundColor: _getBackgroundColor(),
      );
    }

    return const TextStyle(
      fontSize: 30.0,
      color: Colors.black,
    );
  }

  Color _getBackgroundColor() {
    if (_letterState == LetterState.notInWord) {
      return Colors.grey.shade600;
    } else if (_letterState == LetterState.wrongSpot) {
      return Colors.yellow.shade600;
    } else if (_letterState == LetterState.correctSpot) {
      return Colors.green.shade600;
    }
    return Colors.transparent;
  }
}
