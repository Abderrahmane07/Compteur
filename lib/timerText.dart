// import 'dart:async';

// import 'package:flutter/material.dart';

// class TimerText extends StatefulWidget {
//   TimerText({required this.stopwatch});
//   final Stopwatch stopwatch;

//   TimerTextState createState() => new TimerTextState(stopwatch: stopwatch);
// }

// class TimerTextState extends State<TimerText> {
//   Timer? timer;
//   final Stopwatch stopwatch;

//   TimerTextState({required this.stopwatch}) {
//     timer = new Timer.periodic(new Duration(milliseconds: 30), callback);
//   }

//   void callback(Timer timer) {
//     if (stopwatch.isRunning) {
//       setState(() {});
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final TextStyle timerTextStyle =
//         const TextStyle(fontSize: 60.0, fontFamily: "Open Sans");
//     String formattedTime =
//         TimerTextFormatter.format(stopwatch.elapsedMilliseconds);
//     return new Text(formattedTime, style: timerTextStyle);
//   }
// }
