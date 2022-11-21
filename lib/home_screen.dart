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
  int clientOrder = 1;
  List<int> priceForClientsList = [0, 1, 2];
  // int timeFirstClient = 5;
  List<bool> isLaunchedList = [false, false, false];

  void _startOrResetCountDown1() {
    Timer.periodic(Duration(seconds: 1), (timer1) {
      setState(() {
        if (isLaunchedList[0]) {
          priceForClientsList[0]++;
        } else {
          timer1.cancel();
          priceForClientsList[0] = 0;
          isLaunchedList[0] = false;
        }
      });
    });
  }

  void _startOrResetCountDown2() {
    Timer.periodic(Duration(seconds: 1), (timer2) {
      setState(() {
        if (isLaunchedList[1]) {
          priceForClientsList[1]++;
        } else {
          timer2.cancel();
          priceForClientsList[1] = 0;
          isLaunchedList[1] = false;
        }
      });
    });
  }

  void _startOrResetCountDown3() {
    Timer.periodic(Duration(seconds: 1), (timer3) {
      setState(() {
        if (isLaunchedList[2]) {
          priceForClientsList[2]++;
        } else {
          timer3.cancel();
          priceForClientsList[2] = 0;
          isLaunchedList[2] = false;
        }
      });
    });
  }

  void nextClient() {
    setState(() {
      if (clientOrder == 1) {
        clientOrder = 2;
      } else if (clientOrder == 2) {
        clientOrder = 3;
      } else {
        clientOrder = 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                        isLaunchedList[clientOrder - 1] =
                            !isLaunchedList[clientOrder - 1];
                        if (clientOrder == 1) {
                          _startOrResetCountDown1();
                        } else if (clientOrder == 2) {
                          _startOrResetCountDown2();
                        } else {
                          _startOrResetCountDown3();
                        }
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
                        nextClient();
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
            child: Row(
              children: [
                const SizedBox(
                  width: 30,
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    SevenSegmentDisplay(
                      value: clientOrder
                          .toString(), // clientOrder != Null ? clientOrder.toString() : '0',
                      size: 5.0,
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    Container(
                      width: 20.0,
                      height: 20.0,
                      decoration: const BoxDecoration(
                          color: Colors.red, shape: BoxShape.circle),
                    ),
                  ],
                ),
                Expanded(child: Container()),
                Center(
                  child: SevenSegmentDisplay(
                    value: priceForClientsList[clientOrder - 1].toString(),
                    size: 11.0,
                  ),
                  // SevenSegmentDisplay(
                  //   value: "123",
                  //   size: 12.0,
                  // ),
                ),
                const SizedBox(
                  width: 15,
                ),
              ],
            ),
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
