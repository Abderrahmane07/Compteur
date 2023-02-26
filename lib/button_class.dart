import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class ButtonToImplemet {
  Widget buttonToReturn(Color couleur, Function fofo, String mess,
      [bool askForPermission = false]) {
    return Tooltip(
      message: mess,
      child: SizedBox(
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
          onPressed: () async {
            if (askForPermission) {
              PermissionStatus locationStatus =
                  await Permission.location.request();

              if (locationStatus == PermissionStatus.granted) {
                print("Already has the permission");
                fofo();
              }
              if (locationStatus == PermissionStatus.denied) {
                print("no, you're denied");
              }
              if (locationStatus == PermissionStatus.permanentlyDenied) {
                print("Permanently denied");
                openAppSettings();
              }
            } else {
              fofo();
            }
          },
          child: const Text(''),
        ),
      ),
    );
  }
}
