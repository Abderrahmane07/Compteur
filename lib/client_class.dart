// Our client's class should contain:
// - the initial price for the client (?),
// - the actual price that the client should pay,
// - a bool of wether the counter is launched for him
// - the latitude and the longitude of his actual position
// - the latitude and the longitude of his previous location
// - the second's counter that verifies when to check the user's location
// - the function that starts the countdown and resets it.

import 'dart:async';

class Client {
  int priceUnit = 0;
  double finalPrice = 0;
  bool isLaunched = false;
  double? latitude;
  double? longitude;
  int secondsCounter = 0;
  Timer? timer;

  double distance = 0;
  List<double?> list1 = [0, 0]; // [Latitude, Longitude]
  List<double?> list2 = [0, 0];
  int i = 1;
//   Client(this.priceUnit, this.finalPrice, this.isLaunched, this.latitude,
// );
  // Client();

  // void startOrResetCountDown(double chute) {
  //   Timer.periodic(Duration(seconds: 1), (timer) {
  //     if (isLaunched) {
  //       priceUnit++;
  //       finalPrice = chute * priceUnit;
  //     } else {
  //       timer.cancel();
  //       priceUnit = 0;
  //       finalPrice = 0;
  //       isLaunched = false;
  //     }
  //   });
  // }
}
