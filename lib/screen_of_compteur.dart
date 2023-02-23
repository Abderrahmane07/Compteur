import 'package:flutter/material.dart';
import 'package:segment_display/segment_display.dart';

class ScreenOfCompteur {
  Widget screenToPlace(bool isOn, int clientOrder, bool isNightTarriff,
      List<double> finalPriceForClientsList) {
    return Container(
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
                    isNightTarriff
                        ? Container(
                            width: 20.0,
                            height: 20.0,
                            decoration: const BoxDecoration(
                                color: Colors.red, shape: BoxShape.circle),
                          )
                        : Container(),
                  ],
                ),
                Expanded(child: Container()),
                Center(
                  child: SevenSegmentDisplay(
                    value: finalPriceForClientsList[clientOrder - 1]
                        .toStringAsFixed(2),
                    size: 11.0,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
              ],
            )
          : Row(),
    );
  }
}
