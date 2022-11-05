import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        scaffoldBackgroundColor: const Color.fromARGB(255, 67, 61, 61),
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
      //backgroundColor: Color.fromARGB(255, 67, 61, 61),
      body: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
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
                  MaterialButton(
                    onPressed: () {},
                    child: const Text('Coco'),
                  ),
                  // const SizedBox(
                  //   height: 70,
                  //   width: 70,
                  //   child: DecoratedBox(
                  //     decoration: BoxDecoration(
                  //         color: Color.fromARGB(255, 48, 182, 97)),
                  //   ),
                  // ),
                  const SizedBox(
                    width: 30,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Coco'),
                  ),
                  // SizedBox(
                  //   height: 70,
                  //   width: 70,
                  //   child: DecoratedBox(
                  //     decoration: BoxDecoration(
                  //         color: Color.fromARGB(255, 208, 183, 153)),
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Coco'),
                  ),
                  // const SizedBox(
                  //   height: 70,
                  //   width: 70,
                  //   child: DecoratedBox(
                  //     decoration: BoxDecoration(
                  //         color: Color.fromARGB(255, 208, 183, 153)),
                  //   ),
                  // ),
                  const SizedBox(
                    width: 30,
                  ),
                  // OutlinedButton(
                  //   style: OutlinedButton.styleFrom(
                  //     backgroundColor:
                  //         Color.fromARGB(255, 208, 183, 153), //<-- SEE HERE
                  //   ),

                  //   onPressed: () {},
                  //   child: const Text('Coco'),
                  // ),
                  SizedBox(
                    height: 70,
                    width: 70,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor:
                            Color.fromARGB(255, 208, 183, 153), //<-- SEE HERE
                      ),
                      onPressed: () {},
                      child: const Text('Coco'),
                    ),
                    // DecoratedBox(
                    //   decoration: BoxDecoration(
                    //       color: Color.fromARGB(255, 208, 183, 153)),
                    // ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            width: 60,
          ),
          // bloc 2: counter
          const SizedBox(
            height: 200,
            width: 400,
            child: DecoratedBox(
              decoration: BoxDecoration(color: Colors.red),
            ),
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
