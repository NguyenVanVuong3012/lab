import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DicePage(),
    );
  }
}

class DicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Dice Page'),
      ),
      body: Dice(),
    );
  }
}

class Dice extends StatefulWidget {
  const Dice({Key? key}) : super(key: key);

  @override
  _DicePageState createState() => _DicePageState();
}

class _DicePageState extends State<Dice> {
  int mNumber = 1;
  int mNumberR = 1;

  void state() {
    setState(() {
      mNumber = Random().nextInt(6) + 1;
      mNumberR = Random().nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: <Widget>[
          Expanded(
              child: TextButton(
            onPressed: () {
              setState(() {
                // state();
                mNumber = Random().nextInt(6) + 1;

              });
            },
            child: Image.asset('images/m$mNumber.jpg'),
          )),
          Expanded(
              child: TextButton(
            onPressed: () {
              setState(() {
                // state();
                mNumberR = Random().nextInt(6) + 1;
              });
            },
            child: Image.asset('images/m$mNumberR.jpg'),
          ))
        ],
      ),
    );
  }
}