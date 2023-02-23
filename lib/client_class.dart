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
  int initialPrice = 0;
  double? finalPrice;
  bool isLaunched = false;
  double? latitude;
  double? longitude;
  int? secondsCounter = 0;
  Timer? timer;

  // Client();

}
