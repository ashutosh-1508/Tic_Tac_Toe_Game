import 'package:flutter/material.dart';

import 'package:tic_tac_toe_game/View/start_screen.dart';

void main() {
  runApp(MyGameApp());
}

class MyGameApp extends StatelessWidget {
  const MyGameApp({super.key});

  @override
  Widget build(BuildContext context) { 
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GameStartScreen(),
    );
  }
}
