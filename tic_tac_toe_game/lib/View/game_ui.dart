import 'dart:async';
import 'dart:developer';

import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TicTacToeGame extends StatefulWidget {
  const TicTacToeGame({super.key});

  @override
  State createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State {


  List<String> displayXO = List.filled(9, '');

  bool oturn = true;

  bool isConfettiPlaying = false;
  static const maxSeconds = 30;
  int seconds = maxSeconds;
  Timer? timer;
  int scoreO = 0;
  int scoreX = 0;
  int boxesclicked = 0;
  bool winnerFound = false;
  bool isStart = false;
  int attempt = 0;

  String winner = '';

  _tapped(int index) {
    setState(() {
      if (!winnerFound) {
        if (oturn && displayXO[index] == '') {
          displayXO[index] = 'O';
          boxesclicked++;
        } else if (!oturn && displayXO[index] == '') {
          displayXO[index] = 'X';
          boxesclicked++;
        }

        oturn = !oturn;
        _checkWinner();
      }
    });
  }

  dynamic _winnerDialogBox(String winner) async {
    ConfettiController confettiController = ConfettiController(
      duration: Duration(milliseconds: 1000),
    );

    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Stack(
          alignment: Alignment.center,
          children: [
            ConfettiWidget(
              confettiController: confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: true,
              emissionFrequency: 1,
              numberOfParticles: 25,
              gravity: 0.4,
            ),
            ScaleTransition(
              scale: CurvedAnimation(
                parent: AnimationController(
                  vsync: Navigator.of(context),
                  duration: const Duration(milliseconds: 1000),
                )..forward(),
                curve: Curves.bounceOut,
              ),
              child: CupertinoAlertDialog(
                title: Center(
                  child: (winner == 'Draw')
                      ? Text(
                          winner,
                          style: GoogleFonts.bubblegumSans(fontSize: 50),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Player",
                              style: GoogleFonts.bubblegumSans(fontSize: 40),
                            ),
                            Text(
                              "$winner",
                              style: GoogleFonts.bubblegumSans(
                                fontSize: 40,
                                color: (winner == 'O')
                                    ? Colors.red
                                    : Colors.green,
                              ),
                            ),
                            Text(
                              "Wins",
                              style: GoogleFonts.bubblegumSans(fontSize: 40),
                            ),
                          ],
                        ),
                ),
                actions: [
                  //Restart Game
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                      onPressed: () {
                        _clearBox();
                        winnerFound = false;
                        scoreO = 0;
                        scoreX = 0;
                        attempt = 0;
                        winner = '';
                        Navigator.of(context).pop();
                        setState(() {});
                      },
                      child: Icon(Icons.replay, size: 60, color: Colors.green),
                    ),
                  ),

                  // Replay Game
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                      onPressed: () {
                        _clearBox();
                        winnerFound = false;
                        winner = '';
                        Navigator.of(context).pop();
                        setState(() {});
                      },
                      child: Icon(
                        Icons.play_arrow,
                        size: 60,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _clearBox() {
    setState(() {
      displayXO = List.filled(9, '');
      log("$displayXO");
      boxesclicked = 0;
    });
  }

  void _checkWinner() {
    //first Row

    if (displayXO[0] == displayXO[1] &&
        displayXO[0] == displayXO[2] &&
        displayXO[0] != '') {
      winner = "Player ${displayXO[0]} Wins";
      winnerFound = !winnerFound;
      updateScore(displayXO[0]);
      isConfettiPlaying = true;
      _winnerDialogBox(displayXO[0]);

      setState(() {});
      //second Row
    } else if (displayXO[3] == displayXO[4] &&
        displayXO[3] == displayXO[5] &&
        displayXO[3] != '') {
      winner = "Player ${displayXO[3]} Wins";
      winnerFound = !winnerFound;
      updateScore(displayXO[3]);
      _winnerDialogBox(displayXO[3]);
      setState(() {});
    }
    //third Row
    else if (displayXO[6] == displayXO[7] &&
        displayXO[6] == displayXO[8] &&
        displayXO[6] != '') {
      winner = "Player ${displayXO[6]} Wins";
      winnerFound = !winnerFound;
      updateScore(displayXO[6]);
      _winnerDialogBox(displayXO[6]);

      setState(() {});
    }
    //first column
    else if (displayXO[0] == displayXO[3] &&
        displayXO[0] == displayXO[6] &&
        displayXO[0] != '') {
      winner = "Player ${displayXO[0]} Wins";
      winnerFound = !winnerFound;
      updateScore(displayXO[0]);
      _winnerDialogBox(displayXO[0]);
      setState(() {});
    }
    //second column
    else if (displayXO[1] == displayXO[4] &&
        displayXO[1] == displayXO[7] &&
        displayXO[1] != '') {
      winner = "Player ${displayXO[1]} Wins";
      winnerFound = !winnerFound;
      updateScore(displayXO[1]);
      _winnerDialogBox(displayXO[1]);
      setState(() {});
    }
    //third column
    else if (displayXO[2] == displayXO[5] &&
        displayXO[2] == displayXO[8] &&
        displayXO[2] != '') {
      winner = "Player ${displayXO[2]} Wins";
      winnerFound = !winnerFound;
      updateScore(displayXO[2]);
      _winnerDialogBox(displayXO[2]);
      setState(() {});
    }
    //left digonal
    else if (displayXO[0] == displayXO[4] &&
        displayXO[0] == displayXO[8] &&
        displayXO[0] != '') {
      winner = "Player ${displayXO[0]} Wins";
      winnerFound = !winnerFound;
      updateScore(displayXO[0]);
      _winnerDialogBox(displayXO[0]);
      setState(() {});
    }
    //right diagonal
    else if (displayXO[2] == displayXO[4] &&
        displayXO[2] == displayXO[6] &&
        displayXO[2] != '') {
      winner = "Player ${displayXO[2]} Wins";
      winnerFound = !winnerFound;
      updateScore(displayXO[2]);
      _winnerDialogBox(displayXO[2]);
      setState(() {});
    } else if (boxesclicked == 9) {
      winner = "Draw";
      _winnerDialogBox("Draw");
      setState(() {});
    }
  }

  updateScore(String winner) {
    if (winner == 'O') {
      scoreO++;
    } else if (winner == 'X') {
      scoreX++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 244, 244, 244),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Player X",
                        style: GoogleFonts.robotoMono(fontSize: 20),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              blurRadius: 30,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "$scoreX | $scoreO",
                              style: GoogleFonts.robotoMono(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "Player O",
                        style: GoogleFonts.robotoMono(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _tapped(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Center(
                          child: Text(
                            displayXO[index],
                            style: GoogleFonts.monoton(
                              textStyle: TextStyle(
                                fontSize: 74,
                                color: displayXO[index] == 'O'
                                    ? Colors.red
                                    : Colors.lightGreen,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
