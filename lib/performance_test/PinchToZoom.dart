import 'package:flutter/material.dart';

class PinchToZoom extends StatelessWidget{
  const PinchToZoom({super.key});
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pinch to zoom test"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: InteractiveViewer(
          panEnabled: true,

          boundaryMargin: const EdgeInsets.all(10000),
          minScale: 0.01,
          maxScale: 5.0,
          child: const Image(image: AssetImage('assets/images2/logo.png')),
        )
        ),
      )
      );
  }
}