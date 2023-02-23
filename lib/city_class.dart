// Our city's class should contain:
// - the initial price for clients in this city,
// - the distance upon which the price changes,
// - La chute, the amount of money that the price changes upon this distance and / or a minute waiting
// - The diameter of the earth on this city

// ignore_for_file: constant_identifier_names

import 'dart:async';

enum Cities { Casablanca, Tangier, Rabat, Fez, Tetouan, Custom }

class City {
  double? intialPriceCity;
  int? distanceToChange;
  double? chute;
  int earthDiameter = 12741744; // with meters in Tangier

  City(this.intialPriceCity, this.distanceToChange, this.chute,
      this.earthDiameter);

  // Client();
}
