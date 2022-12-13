import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class TestLocationScreen extends StatefulWidget {
  const TestLocationScreen({Key? key}) : super(key: key);

  @override
  State<TestLocationScreen> createState() => _TestLocationScreenState();
}

class _TestLocationScreenState extends State<TestLocationScreen> {
  var locationMessage = '';

  void getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lastPosition = await Geolocator.getLastKnownPosition();
    print(lastPosition);
    setState(() {
      locationMessage = "${position.latitude} , ${position.longitude}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("coco"),
            SizedBox(
              height: 50,
            ),
            TextButton(
              onPressed: () {
                getCurrentLocation();
                print(locationMessage);
              },
              child: Text("Get current Position"),
            )
          ],
        ),
      ),
    );
  }
}
