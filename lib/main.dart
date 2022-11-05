import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:segment_display/segment_display.dart';

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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 67, 61, 61),
      body: Row(
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
                  SizedBox(
                    height: 70,
                    width: 70,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        side: const BorderSide(width: 2),
                        backgroundColor: const Color.fromARGB(255, 48, 182, 97),
                      ),
                      onPressed: () {},
                      child: const Text(''),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  SizedBox(
                    height: 70,
                    width: 70,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        side: const BorderSide(width: 2),
                        backgroundColor:
                            const Color.fromARGB(255, 208, 183, 153),
                      ),
                      onPressed: () {},
                      child: const Text(''),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  SizedBox(
                    height: 70,
                    width: 70,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        side: const BorderSide(width: 2),
                        backgroundColor:
                            const Color.fromARGB(255, 208, 183, 153),
                      ),
                      onPressed: () {},
                      child: const Text(''),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  SizedBox(
                    height: 70,
                    width: 70,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        side: const BorderSide(width: 2),
                        backgroundColor:
                            const Color.fromARGB(255, 208, 183, 153),
                      ),
                      onPressed: () {},
                      child: const Text(''),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            width: 60,
          ),
          // bloc 2: counter
          Container(
            height: 200,
            width: 400,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            child: const Center(
              child: SevenSegmentDisplay(
                value: "123",
                size: 12.0,
              ),
            ),
            // DecoratedBox(
            //   decoration: BoxDecoration(color: Colors.red),
            // ),
          ),
          Expanded(child: Container()),
          // bloc 3: ad
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: 70,
            child: const DecoratedBox(
              decoration: BoxDecoration(color: Color.fromARGB(255, 0, 34, 255)),
            ),
          ),
        ],
      ),
    );
  }
}
