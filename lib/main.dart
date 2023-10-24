import 'package:embedded_hmi_flutter/performance_test/Multitouch.dart';
import 'package:flutter/material.dart';
import 'package:embedded_hmi_flutter/performance_test/PinchToZoom.dart';
import 'package:touch_indicator/touch_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SMD Raspberry Test',
      builder: (context, child) => TouchIndicator(
        child: child!,
      ),
      home: const TouchIndicator(
        child: MyHomePage(
          title: 'Flutter Raspberry Test Homepage',
        ),
      ),
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
          useMaterial3: true,
          fontFamily: "Poppins",
          textTheme: const TextTheme(
              titleLarge: TextStyle(fontSize: 38.0),
              displayLarge: TextStyle(fontSize: 38.0),
              labelLarge: TextStyle(fontSize: 38.0, fontWeight: FontWeight.bold))),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Multitouch()),
                    );
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.height * 0.4,
                      height: MediaQuery.of(context).size.height * 0.4,
                      color: Theme.of(context).colorScheme.primaryContainer,
                      child: const Center(
                        child: Text("Multitouch"),
                      ))),
              MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PinchToZoom()),
                    );
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.height * 0.4,
                      height: MediaQuery.of(context).size.height * 0.4,
                      color: Theme.of(context).colorScheme.primaryContainer,
                      child: const Center(
                        child: Text("Gestures"),
                      ))),
              MaterialButton(
                onPressed: () {
                },
                child: Container(
                  width: MediaQuery.of(context).size.height * 0.4,
                  height: MediaQuery.of(context).size.height * 0.4,
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: const Center(child: Text("Scrolling")),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
