import 'dart:async';

import 'package:compeur/test_location_screen.dart';
import 'package:compeur/tests_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:segment_display/segment_display.dart';
import 'dart:math' show cos, sqrt, asin;

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int clientOrder = 1;
  List<int> priceForClientsList = [5, 1, 2];
  List<double> finalPriceForClientsList = [0, 0, 0];
  double chute = 0.20; // Tarif à payer par minute écoulée
  bool isNightTarif = false;
  bool isOn = false;
  List<bool> isLaunchedList = [false, false, false];
  // var locationMessage = '';

  Future<List<double?>> getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    var lastPosition = await Geolocator.getLastKnownPosition();
    double? lat = lastPosition?.latitude;
    double? lon = lastPosition?.longitude;
    return [lat, lon];
    // print(lastPosition);
    // setState(() {
    //   // locationMessage = "${position.latitude} , ${position.longitude}";

    // });
  }

  double distance = 0;
  List<double?> list1 = [0, 0];
  List<double?> list2 = [0, 0];
  int i = 1;
  // Now we are going to try to implement the possibility of getting the price also by position and the travelled distance
  Future<void> priceByDistance() async {
    list2 = await getCurrentLocation();
    setState(() {
      print(distance);
      distance += calculateDistance(list1[0], list1[1], list2[0], list2[1]);
      list1 = list2;
      if (distance > (8 * i)) {
        priceForClientsList[0]++;
        i++;
      }
    });
  }

  // This function gives the distance between thow points, the returned result depends on the diameter of the earth
  // wich is the one of Bordeaux's
  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12735092 * asin(sqrt(a));
  }

  // In this part there is a brut-forcing solution to separate the counters and to be working all the ime without interruption,
  // by separating the same function into 3 separate ones for each client, we should go back to this to resolve it in a more
  // elegant way, of course after having a functionnal app
  int secondsCounter = 0;
  Future<void> _startOrResetCountDown1() async {
    list1 = await getCurrentLocation();
    Timer.periodic(Duration(seconds: 1), (timer1) {
      secondsCounter++;
      print(priceForClientsList[0]);
      // The secondsCounter here is used to allow us to make the call to get the user's location every 2 seconds
      if (secondsCounter % 2 == 0) {
        priceByDistance();
      }
      if (isLaunchedList[0]) {
        setState(() {
          priceForClientsList[0]++;
          finalPriceForClientsList[0] = chute * priceForClientsList[0];
        });
      } else {
        setState(() {
          timer1.cancel();
          i = 0;
          distance = 0;
          priceForClientsList[0] = 0;
          finalPriceForClientsList[0] = 0;
          isLaunchedList[0] = false;
        });
      }
    });
  }

  void _startOrResetCountDown2() {
    Timer.periodic(Duration(seconds: 1), (timer2) {
      setState(() {
        if (isLaunchedList[1]) {
          priceForClientsList[1]++;
          finalPriceForClientsList[1] = chute * priceForClientsList[1];
        } else {
          timer2.cancel();
          priceForClientsList[1] = 0;
          finalPriceForClientsList[1] = 0;
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
          finalPriceForClientsList[2] = chute * priceForClientsList[2];
        } else {
          timer3.cancel();
          priceForClientsList[2] = 0;
          finalPriceForClientsList[2] = 0;
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

  void switchOnOff() {
    setState(() {
      isLaunchedList = [false, false, false];
      priceForClientsList = [0, 1, 2];
      clientOrder = 1;
      if (isNightTarif) {
        switchToNightMode();
      }
      isOn = !isOn;
    });
  }

  void switchToNightMode() {
    setState(() {
      isNightTarif = !isNightTarif;
      isNightTarif ? chute = 0.3 : chute = 0.2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 67, 61, 61),
      body: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 40,
              ),
              Row(
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
                            //Button 1
                            height: 70,
                            width: 70,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                side: const BorderSide(width: 2),
                                backgroundColor:
                                    const Color.fromARGB(255, 48, 182, 97),
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
                            //Button 2
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
                            //Button 3
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
                                switchOnOff();
                              },
                              child: const Text(''),
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          SizedBox(
                            //Button 4
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
                                switchToNightMode();
                                // Navigator.of(context).push(
                                //   MaterialPageRoute(
                                //     builder: (context) => TestsScreen(),
                                //   ),
                                // );
                              },
                              onLongPress: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => TestLocationScreen(),
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
                    // To switch it on and off we just test that bool and if it's true we display content, otherwise just an empty Row
                    child: isOn
                        ? Row(
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
                                  isNightTarif
                                      ? Container(
                                          width: 20.0,
                                          height: 20.0,
                                          decoration: const BoxDecoration(
                                              color: Colors.red,
                                              shape: BoxShape.circle),
                                        )
                                      : Container(),
                                ],
                              ),
                              Expanded(child: Container()),
                              Center(
                                child: SevenSegmentDisplay(
                                  value: finalPriceForClientsList[
                                          clientOrder - 1]
                                      .toStringAsFixed(
                                          2), //" ${priceForClientsList[clientOrder - 1]}.00",
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
                          )
                        : Row(),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 10,
                    width: 240,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 48, 132, 112),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text(
                    "LARCHI",
                    style: TextStyle(
                      fontSize: 40,
                      color: Color.fromARGB(255, 48, 132, 112),
                      letterSpacing: 6,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Container(
                    height: 10,
                    width: 197,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 48, 132, 112),
                    ),
                  ),
                ],
              ),
            ],
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
