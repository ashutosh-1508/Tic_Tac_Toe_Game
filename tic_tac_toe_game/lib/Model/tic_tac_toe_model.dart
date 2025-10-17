import 'dart:async';

class TicTacToeModel {
  bool oturn = true;

  bool isConfettiPlaying = false;
  int maxSeconds = 30;
  late int seconds = maxSeconds;
  Timer? timer;
  int scoreO = 0;
  int scoreX = 0;
  int boxesclicked = 0;
  bool winnerFound = false;
  bool isStart = false;
  int attempt = 0;

  String winner = '';

  TicTacToeModel({
    this.oturn = true,
    this.isConfettiPlaying = false,
    this.maxSeconds = 30,
    this.timer,
    this.scoreO = 0,
    this.scoreX = 0,
    this.boxesclicked = 0,
    this.winnerFound = false,
    this.attempt = 0,
    this.winner=''
  });
}
