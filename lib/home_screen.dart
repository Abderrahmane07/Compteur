import 'dart:async';

import 'package:compeur/button_class.dart';
import 'package:compeur/client_class.dart';
import 'package:compeur/screen_of_compteur.dart';
// import 'package:compeur/test_location_screen.dart';
// import 'package:compeur/tests_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:segment_display/segment_display.dart';
import 'dart:math' show cos, sqrt, asin;

import 'city_class.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  City tangier = City(1.6, 100, 0.3, 12741744);
  City casablanca = City(2.0, 80, 0.2, 12743254);
  Client client1 = Client();
  Client client2 = Client();
  Client client3 = Client();
  int clientOrder = 1;
  List<int> priceForClientsList = [0, 1, 2];
  List<double> finalPriceForClientsList = [0, 0, 0];
  double chute =
      0.20; // Tarif à payer par minute écoulée ou par unité de disatnce traversée
  bool isNightTarriff = false;
  bool isOn = true;
  List<bool> isLaunchedList = [false, false, false];
  // List<bool> isLaunchedList2 = [client1.isLaunched, false, false];
  // var locationMessage = '';

  Future<List<double?>> getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    // var lastPosition = await Geolocator.getLastKnownPosition();
    double? lat = position.latitude;
    double? lon = position.longitude;
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
    //print('2nd: ce que contient la liste 1 avant :' + list1.toString());
    //print('3rd: ce que contient la liste 2 avant :' + list2.toString());
    list2 = await getCurrentLocation();
    //print('4th: ce que contient la liste 1 après :' + list1.toString());
    //print('5th: ce que contient la liste 2 après :' + list2.toString());
    setState(() {
      print('6th' + distance.toString());
      distance += calculateDistance(list1[0], list1[1], list2[0], list2[1]);
      list1 = list2;
      if (distance > (8 * i)) {
        priceForClientsList[0]++;
        i++;
      }
    });
  }

  // This function gives the distance between two points, the returned result depends on the diameter of the earth
  // wich is the one of Bordeaux's here
  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return tangier.earthDiameter * asin(sqrt(a));
  }

  // In this part there is a brut-forcing solution to separate the counters and to be working all the ime without interruption,
  // by separating the same function into 3 separate ones for each client, we should go back to this to resolve it in a more
  // elegant way, of course after having a functionnal app
  int secondsCounter = 0;
  Future<void> _startOrResetCountDown1() async {
    list1 = await getCurrentLocation();
    Timer.periodic(Duration(seconds: 1), (timer1) {
      secondsCounter++;
      print('1st' + priceForClientsList[0].toString());
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

  void _startOrResetCountDown(Client client, int clientOrder) {
    client.isLaunched = !client.isLaunched;
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (client.isLaunched) {
          client.priceUnit++;
          client.finalPrice = chute * client.priceUnit;
          print(client.finalPrice);
          finalPriceForClientsList[clientOrder - 1] = client.finalPrice;
        } else {
          timer.cancel();
          client.priceUnit = 0;
          client.finalPrice = 0;
          client.isLaunched = false;
          finalPriceForClientsList[clientOrder - 1] = 0;
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
      if (isNightTarriff) {
        switchToNightTarriff();
      }
      isOn = !isOn;
    });
  }

  void switchToNightTarriff() {
    setState(() {
      isNightTarriff = !isNightTarriff;
      isNightTarriff ? chute = 0.3 : chute = 0.2;
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
                          // Button 1
                          ButtonToImplemet().buttonToReturn(
                              const Color.fromARGB(255, 48, 182, 97),
                              onPressedButton),
                          const SizedBox(
                            width: 30,
                          ),
                          // Button 2
                          ButtonToImplemet().buttonToReturn(
                              const Color.fromARGB(255, 208, 183, 153),
                              nextClient),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          // Button 3
                          ButtonToImplemet().buttonToReturn(
                              const Color.fromARGB(255, 208, 183, 153),
                              switchOnOff),
                          const SizedBox(
                            width: 30,
                          ),
                          // Button 4
                          ButtonToImplemet().buttonToReturn(
                              const Color.fromARGB(255, 208, 183, 153),
                              switchToNightTarriff),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 60,
                  ),
                  // bloc 2: counter
                  ScreenOfCompteur().screenToPlace(isOn, clientOrder,
                      isNightTarriff, finalPriceForClientsList),
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

  void onPressedButton() {
    isLaunchedList[clientOrder - 1] = !isLaunchedList[clientOrder - 1];
    if (clientOrder == 1) {
      _startOrResetCountDown1();
    } else if (clientOrder == 2) {
      _startOrResetCountDown(client2, clientOrder);
    } else {
      _startOrResetCountDown(client3, clientOrder);
    }
  }
}
