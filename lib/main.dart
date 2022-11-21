import 'package:compeur/tests_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Next 3 lines control the possible orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          // scaffoldBackgroundColor: const Color.fromARGB(255, 67, 61, 61),
          ),
      // home: const MyHomePage(),
      routes: {
        '/': (context) => HomeScreen(),
        '/tests': (context) => const TestsScreen(),
      },
    );
  }
}
