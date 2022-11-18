// import 'package:compeur/timerText.dart';
// import 'package:flutter/material.dart';

// class TimerPage extends StatefulWidget {
//   TimerPage({}) : super(key: key);

//   TimerPageState createState() => new TimerPageState();
// }

// class TimerPageState extends State<TimerPage> {
//   Stopwatch stopwatch = new Stopwatch();

//   void leftButtonPressed() {
//     setState(() {
//       if (stopwatch.isRunning) {
//         print("${stopwatch.elapsedMilliseconds}");
//       } else {
//         stopwatch.reset();
//       }
//     });
//   }

//   void rightButtonPressed() {
//     setState(() {
//       if (stopwatch.isRunning) {
//         stopwatch.stop();
//       } else {
//         stopwatch.start();
//       }
//     });
//   }

//   Widget buildFloatingButton(String text, VoidCallback callback) {
//     TextStyle roundTextStyle =
//         const TextStyle(fontSize: 16.0, color: Colors.white);
//     return new FloatingActionButton(
//         child: new Text(text, style: roundTextStyle), onPressed: callback);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Column(
//       children: <Widget>[
//         new Container(
//             height: 200.0,
//             child: new Center(
//               child: new TimerText(stopwatch: stopwatch),
//             )),
//         new Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               buildFloatingButton(
//                   stopwatch.isRunning ? "lap" : "reset", leftButtonPressed),
//               buildFloatingButton(
//                   stopwatch.isRunning ? "stop" : "start", rightButtonPressed),
//             ]),
//       ],
//     );
//   }
// }
