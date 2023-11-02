import 'package:flutter/material.dart';

class MultiTouch extends StatefulWidget {
  const MultiTouch({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MultiTouchState();
}

class _MultiTouchState extends State<MultiTouch> {
  late int touchPoints;

  @override
  void initState() {
    super.initState();
    touchPoints = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
        onPointerDown: (opm) {
          touchPoints += 1;
          setState(() {});
        },
        onPointerUp: (opm) {
          touchPoints -= 1;
          setState(() {});
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Multitouch"),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          body: Container(
              padding: const EdgeInsets.all(25),
              child: Text(
                "Number of touch points: $touchPoints",
                style: const TextStyle(fontSize: 30),
              )),
        ));
  }
}
