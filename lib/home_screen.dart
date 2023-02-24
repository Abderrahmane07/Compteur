import 'dart:async';

import 'package:compeur/button_class.dart';
import 'package:compeur/client_class.dart';
import 'package:compeur/screen_of_compteur.dart';
// import 'package:compeur/test_location_screen.dart';
// import 'package:compeur/tests_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:segment_display/segment_display.dart';
import 'dart:math' show cos, sqrt, asin;

import 'city_class.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // This part will be only for ads
  @override
  void initState() {
    super.initState();
    initBannerAd();
  }

  late BannerAd bannerAd;
  var adUnit = "ca-app-pub-3940256099942544/6300978111"; // testing ad id
  bool isAdLoaded = false;

  initBannerAd() {
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: adUnit,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print(error);
        },
      ),
      request: const AdRequest(),
    );

    bannerAd.load();
  }

  // It ends here

  City tangier = City(1.6, 100, 0.3, 12741744);
  City casablanca = City(2.0, 80, 0.2, 12743254);
  Client client1 = Client();
  Client client2 = Client();
  Client client3 = Client();
  int clientOrder = 1;
  List<double> finalPriceForClientsList = [0, 0, 0];
  //double chute = 0.20; // Tarif à payer par minute écoulée ou par unité de disatnce traversée
  bool isNightTarriff = false;
  bool isOn = true;
  List<bool> isLaunchedList = [false, false, false];

  Future<List<double?>> getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    double? lat = position.latitude;
    double? lon = position.longitude;
    return [lat, lon];
  }

  // Now we are going to try to implement the possibility of getting the price also by position and the travelled distance
  Future<void> priceByDistance(Client client) async {
    client.list2 = await getCurrentLocation();
    setState(() {
      client.distance += calculateDistance(
          client.list1[0], client.list1[1], client.list2[0], client.list2[1]);
      client.list1 = client.list2;
      print(client.distance);
      if (client.distance > (tangier.distanceToChange * client.i)) {
        client.priceUnit++;
        print('upgrade using the distance');
        //  client.i++;
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
  Future<void> _startOrResetCountDownGeneral(
      Client client, int clientOrder) async {
    client.isLaunched = !client.isLaunched;
    client.finalPrice = tangier.intialPriceCity;
    finalPriceForClientsList[clientOrder - 1] = tangier.intialPriceCity;
    client.list1 = await getCurrentLocation();
    Timer.periodic(Duration(seconds: 1), (timer) {
      client.secondsCounter++;
      // The secondsCounter here is used to allow us to make the call to get the user's location every 2 seconds
      if (client.secondsCounter % 2 == 0) {
        priceByDistance(client);
      }
      if (client.isLaunched) {
        setState(() {
          //client.finalPrice =
          //  tangier.intialPriceCity + (tangier.chute * client.priceUnit);
          if (client.secondsCounter % 60 == 0) {
            client.priceUnit++;
            //print('This is the unitPrice' + client.priceUnit.toString());
            client.finalPrice =
                tangier.intialPriceCity + tangier.chute * client.priceUnit;
            finalPriceForClientsList[clientOrder - 1] = client.finalPrice;
          }
        });
      } else {
        setState(() {
          timer.cancel();
          client.i = 0;
          client.distance = 0;
          client.priceUnit = 0;
          client.finalPrice = 0;
          finalPriceForClientsList[clientOrder - 1] = 0;
          client.isLaunched = false;
        });
      }
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
      client1.isLaunched = false;
      client2.isLaunched = false;
      client3.isLaunched = false;
      client1.priceUnit = 0;
      client2.priceUnit = 0;
      client3.priceUnit = 0;
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
      isNightTarriff
          ? tangier.chute = tangier.chute * 1.5
          : tangier.chute = tangier.chute;
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
                              onPressedButton,
                              'Start / Reset'),
                          const SizedBox(
                            width: 30,
                          ),
                          // Button 2
                          ButtonToImplemet().buttonToReturn(
                              const Color.fromARGB(255, 208, 183, 153),
                              nextClient,
                              'Change Client'),
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
                              switchOnOff,
                              'Turn On / Off'),
                          const SizedBox(
                            width: 30,
                          ),
                          // Button 4
                          ButtonToImplemet().buttonToReturn(
                              const Color.fromARGB(255, 208, 183, 153),
                              switchToNightTarriff,
                              'Night Tarriff'),
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
                height: 20,
              ),
              Container(
                height: 55,
                child: Row(
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 10,
                          width: 197,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 48, 132, 112),
                          ),
                        ),
                        SizedBox(
                          height: 1,
                        ),
                        const Text(
                          "MADE IN TANGIER",
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 255, 255, 255),
                            //letterSpacing: 6,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(child: Container()),
          // bloc 3: ad
          isAdLoaded
              // ? SizedBox(
              //     height: bannerAd.size.width.toDouble(),
              //     width: bannerAd.size.height.toDouble(),
              //     child: AdWidget(
              //       ad: bannerAd,
              //     ),
              //   )
              ? SizedBox(
                  height: 400,
                  width: 150,
                  child: AdWidget(
                    ad: bannerAd,
                  ),
                )
              : SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: 70,
                  child: const DecoratedBox(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 153, 153, 153)),
                  ),
                ),
        ],
      ),
    );
  }

  void onPressedButton() {
    isLaunchedList[clientOrder - 1] = !isLaunchedList[clientOrder - 1];
    if (clientOrder == 1) {
      _startOrResetCountDownGeneral(client1, clientOrder);
    } else if (clientOrder == 2) {
      _startOrResetCountDownGeneral(client2, clientOrder);
    } else {
      _startOrResetCountDownGeneral(client3, clientOrder);
    }
  }
}
