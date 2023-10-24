import 'package:finger_painter/finger_painter.dart';
import 'package:flutter/material.dart';

import 'dart:ui' as ui;

class FingerPainter extends StatefulWidget {
  const FingerPainter({Key? key}) : super(key: key);

  @override
  State<FingerPainter> createState() => _FingerPainterState();
}

class _FingerPainterState extends State<FingerPainter> {
  Image? image;
  late PainterController painterController;

  @override
  void initState() {
    super.initState();
    painterController = PainterController()
      ..setStrokeColor(Colors.black)
      ..setMinStrokeWidth(3)
      ..setMaxStrokeWidth(3)
      ..setBlurSigma(0.0)
      ..setPenType(PenType.pencil)
      ..setBlendMode(ui.BlendMode.srcOver);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Painting"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 100,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  style: BorderStyle.solid,
                  width: 4.0,
                ),
                borderRadius: BorderRadius.zero,
                shape: BoxShape.rectangle,
              ),
              child: Painter(
                controller: painterController,
                backgroundColor: Colors.white,
                onDrawingEnded: (bytes) async {
                  setState(() {});
                },
              ),
            ))
      ]),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.delete_forever),
        onPressed: () {
          painterController.clearContent(clearColor: Colors.white);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
