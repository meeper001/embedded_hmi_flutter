import 'package:flutter/material.dart';
import 'dart:math' as math;

class PinchToZoom extends StatefulWidget {
  const PinchToZoom({super.key});

  @override
  State<PinchToZoom> createState() => _PinchToZoomState();
}

class _PinchToZoomState extends State<PinchToZoom> {
  final double _width = 300;
  final double _height = 200;

  Matrix4 _matrix = Matrix4(
    1, 0, 0, 0,
    0, 1, 0, 0,
    0, 0, 1, 0,
    0, 0, 0, 1,
  );

  double _baseScaleFactor = 1.0;
  double _scaleFactor = 1.0;

  double _baseAngleFactor = 0;
  double _angleFactor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Pinch to zoom test"),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Center(
            child: Transform(
                transform: _matrix,
                alignment: Alignment.center,
                child: GestureDetector(
                    onScaleStart: (details) {
                      _baseScaleFactor = _scaleFactor;
                      _baseAngleFactor = _angleFactor;
                    },
                    onScaleUpdate: (details) {
                      _scaleFactor = _baseScaleFactor * details.scale;
                      _angleFactor = _baseAngleFactor + details.rotation;

                      var angleMatrix = Matrix4.identity();
                      angleMatrix[0] = angleMatrix[5] = math.cos(_angleFactor);
                      angleMatrix[1] = math.sin(_angleFactor);
                      angleMatrix[4] = -math.sin(_angleFactor);

                      var scaleMatrix = Matrix4.identity();
                      scaleMatrix[0] = scaleMatrix[5] = _scaleFactor;

                      _matrix = angleMatrix * scaleMatrix;
                      setState(() {});
                    },
                    child: SizedBox(
                      height: _height,
                      width: _width,
                      child: const Image(
                        image: AssetImage('assets/images/logo.png')),
                  ))),
        ));
  }
}
