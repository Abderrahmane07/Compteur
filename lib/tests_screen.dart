import 'dart:async';

import 'package:flutter/material.dart';

class TestsScreen extends StatefulWidget {
  TestsScreen({Key? key}) : super(key: key);

  @override
  State<TestsScreen> createState() => _TestsScreenState();
}

class _TestsScreenState extends State<TestsScreen> {
  int timeLeft = 5;

  void _startCountDown() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        timeLeft++;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              timeLeft.toString(),
              style: const TextStyle(fontSize: 40),
            ),
            Container(
              //margin: EdgeInsets.all(100.0),
              width: 100.0,
              height: 100.0,
              // color: Colors.red,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
            MaterialButton(
                onPressed: _startCountDown,
                // ignore: sort_child_properties_last
                child: const Text(
                  'Start',
                  style: TextStyle(fontSize: 20),
                ),
                color: Colors.white70),
          ],
        ),
      ),
    );
  }
}
