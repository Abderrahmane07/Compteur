import 'package:flutter/material.dart';

class ButtonToImplemet {
  Widget buttonToReturn(Color couleur, Function fofo) {
    return SizedBox(
      height: 70,
      width: 70,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          side: const BorderSide(width: 2),
          backgroundColor: couleur,
        ),
        onPressed: () {
          fofo();
        },
        child: const Text(''),
      ),
    );
  }
}
