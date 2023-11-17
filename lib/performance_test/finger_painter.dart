import 'package:finger_painter/finger_painter.dart';
import 'package:flutter/material.dart';

import 'dart:ui' as ui;

class FingerPainter extends StatefulWidget {
  const FingerPainter({Key? key}) : super(key: key);

  @override
  State<FingerPainter> createState() => _FingerPainterState();
}

class _FingerPainterState extends State<FingerPainter> {
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
      body: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          width: MediaQuery.of(context).size.width /2,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: Color(0x7ff05a96)
          ),
          child: const Center(child:Text("LABYRINTH\ntouch to draw", style: TextStyle(fontSize: 35),)),
        ),
        SizedBox(
            width: MediaQuery.of(context).size.width /2,
            height: MediaQuery.of(context).size.height,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  filterQuality: FilterQuality.none,
                  fit: BoxFit.fill,
                  image: AssetImage("assets/images/labyrinth.png"),
                ),
                borderRadius: BorderRadius.zero,
                shape: BoxShape.rectangle,
              ),
              child: Painter(
                controller: painterController,
                backgroundColor: const Color(0x7ff05a96),
                onDrawingEnded: (bytes) async {
                  setState(() {});
                },
              ),
            ))
      ]),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.delete_forever),
        onPressed: () {
          painterController.clearContent();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
