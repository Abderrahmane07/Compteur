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
  int timeFirstClient = 5;
  bool isLaunched = false;
  void _startOrResetCountDown() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (isLaunched) {
          timeFirstClient++;
        } else {
          timeFirstClient = 5;
          timer.cancel();
          isLaunched = false;
        }
      });
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
                        isLaunched = !isLaunched;
                        _startOrResetCountDown();
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
                      onPressed: () {},
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
                    const SevenSegmentDisplay(
                      value: "2",
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
                    value: "2.00", //timeFirstClient.toString(),
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
