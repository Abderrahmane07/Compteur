import 'dart:async';

import 'package:compeur/tests_screen.dart';
import 'package:flutter/material.dart';
import 'package:segment_display/segment_display.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final tempsInitial = DateTime.now();
  Timer? timer;
  String temps = "coco";
  Stopwatch stopwatch = Stopwatch();

  void leftButtonPressed() {
    setState(() {
      if (stopwatch.isRunning) {
        print("${stopwatch.elapsedMilliseconds}");
      } else {
        stopwatch.reset();
      }
    });
  }

  void rightButtonPressed() {
    setState(() {
      if (stopwatch.isRunning) {
        stopwatch.stop();
      } else {
        stopwatch.start();
      }
    });
  }

  void prixSelontemps() {
    setState(() {
      var tempsTempo = DateTime.now();
      int difference = tempsTempo.difference(tempsInitial).inSeconds;
      // updateState();
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        difference++;
        temps = difference.toString();
      });
    });
  }
  // int seconds = 0, minutes = 0, hours = 0;
  // String digitSeconds = "00", digitMinutes = "00", digitHours = "00";
  // Timer? timer;
  // bool started = false;
  // List laps = [];

  // void stop() {
  //   timer!.cancel();
  //   setState(() {
  //     started = false;
  //   });
  // }

  // void reset() {
  //   timer!.cancel();
  //   setState(() {
  //     seconds = 0;
  //     minutes = 0;
  //     hours = 0;

  //     digitSeconds = "00";
  //     digitMinutes = "00";
  //     digitHours = "00";

  //     started = false;
  //   });
  // }

  // void addLaps() {
  //   String lap = "$digitHours:$digitMinutes:$digitSeconds";
  //   setState(() {
  //     laps.add(lap);
  //   });
  // }

  // void start() {
  //   started = true;
  //   timer = Timer.periodic(Duration(seconds: 1), (timer) {
  //     int localSeconds = seconds + 1;
  //     int localMinutes = minutes;
  //     int localHours = hours;

  //     if (localSeconds > 59) {
  //       if (localMinutes > 59) {
  //         localHours++;
  //         localMinutes = 0;
  //       } else {
  //         localMinutes++;
  //         localSeconds = 0;
  //       }
  //     }
  //     setState(() {
  //       seconds = localSeconds;
  //       minutes = localMinutes;
  //       hours = localHours;
  //       digitSeconds = (seconds >= 10) ? "$seconds" : "0$seconds";
  //       digitSeconds = (minutes >= 10) ? "$minutes" : "0$minutes";
  //       digitSeconds = (hours >= 10) ? "$hours" : "0$hours";
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    prixSelontemps();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 67, 61, 61),
      body: Row(
        children: [
          const SizedBox(
            width: 30,
          ),
          // bloc 1: buttons
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 70,
                    width: 70,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        side: const BorderSide(width: 2),
                        backgroundColor: const Color.fromARGB(255, 48, 182, 97),
                      ),
                      onPressed: () {
                        rightButtonPressed();
                      },
                      child: const Text(''),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  SizedBox(
                    height: 70,
                    width: 70,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        side: const BorderSide(width: 2),
                        backgroundColor:
                            const Color.fromARGB(255, 208, 183, 153),
                      ),
                      onPressed: () {
                        leftButtonPressed();
                      },
                      child: const Text(''),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  SizedBox(
                    height: 70,
                    width: 70,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        side: const BorderSide(width: 2),
                        backgroundColor:
                            const Color.fromARGB(255, 208, 183, 153),
                      ),
                      onPressed: () {},
                      child: const Text(''),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  SizedBox(
                    height: 70,
                    width: 70,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        side: const BorderSide(width: 2),
                        backgroundColor:
                            const Color.fromARGB(255, 208, 183, 153),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => TestsScreen(),
                          ),
                        );
                      },
                      child: const Text(''),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            width: 60,
          ),
          // bloc 2: counter
          Container(
            height: 200,
            width: 400,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            child: Center(
              child: SevenSegmentDisplay(
                value: temps,
                size: 12.0,
              ),
              // SevenSegmentDisplay(
              //   value: "123",
              //   size: 12.0,
              // ),
            ),
            // DecoratedBox(
            //   decoration: BoxDecoration(color: Colors.red),
            // ),
          ),
          Expanded(child: Container()),
          // bloc 3: ad
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: 70,
            child: const DecoratedBox(
              decoration:
                  BoxDecoration(color: Color.fromARGB(255, 153, 153, 153)),
            ),
          ),
        ],
      ),
    );
  }
}
