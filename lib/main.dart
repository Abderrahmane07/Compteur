import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'home_screen.dart';

void main() async {
  var devices = ['7225CEAC1CB92443E2B8CC0F87604709'];
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  // Next 3 lines control the possible orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  RequestConfiguration requestConfiguration =
      RequestConfiguration(testDeviceIds: devices);
  MobileAds.instance.updateRequestConfiguration(requestConfiguration);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routes: {
        '/': (context) => HomeScreen(),
      },
    );
  }
}
