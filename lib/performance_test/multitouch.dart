import 'package:flutter/material.dart';

class Multitouch extends StatelessWidget {
  const Multitouch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: const Text("Multitouch"),
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    )
    );
  }
}