import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimationPerformance extends StatefulWidget {
  const AnimationPerformance({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AnimationPerformanceState();
}

class _AnimationPerformanceState extends State<AnimationPerformance> {
  bool enableMovement = false;
  bool enableRotation = false;
  bool enableScaling = false;
  bool enableOpacity = false;
  double numberOfImages = 4.0;
  List<Widget> imagesList = [];

  @override
  void initState() {
    super.initState();
    imagesList = generateImagesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animation Performance"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Stack(children: imagesList),
      floatingActionButton: controls(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget controls(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all()),
      padding: const EdgeInsets.fromLTRB(25, 80, 20, 20),
      child: Column(
        children: [
          Row(children: [
            Slider(
              value: numberOfImages,
              label: numberOfImages.round().toString(),
              min: 1,
              max: 200,
              divisions: 199,
              onChanged: (double value) {
                setState(() {
                  numberOfImages = value;
                  imagesList = generateImagesList();
                });
              },
            ),
            const Text("Number of objects"),
          ]),
          Row(children: [
            Checkbox(
                value: enableMovement,
                onChanged: (bool? checked) {
                  if (checked != null) {
                    setState(() {
                      enableMovement = checked;
                      imagesList = generateImagesList();
                    });
                  }
                }),
            const Text("Enable Movement")
          ]),
          Row(children: [
            Checkbox(
                value: enableOpacity,
                onChanged: (bool? checked) {
                  if (checked != null) {
                    setState(() {
                      enableOpacity = checked;
                      imagesList = generateImagesList();
                    });
                  }
                }),
            const Text("Enable Opacity")
          ]),
          Row(children: [
            Checkbox(
                value: enableScaling,
                onChanged: (bool? checked) {
                  if (checked != null) {
                    setState(() {
                      enableScaling = checked;
                      imagesList = generateImagesList();
                    });
                  }
                }),
            const Text("Enable Scaling")
          ]),
          Row(children: [
            Checkbox(
                value: enableRotation,
                onChanged: (bool? checked) {
                  if (checked != null) {
                    setState(() {
                      enableRotation = checked;
                      imagesList = generateImagesList();
                    });
                  }
                }),
            const Text("Enable Rotation")
          ]),
        ],
      ),
    );
  }

  List<Widget> generateImagesList() {
    return List.generate(
        numberOfImages.round(),
        (index) => AnimatedImageExample(
            enableOpacity: enableOpacity,
            enableRotation: enableRotation,
            enableMovement: enableMovement,
            enableScaling: enableScaling));
  }
}

class AnimatedImageContainer extends AnimatedWidget {
  final double opacity;
  final double rotationSpeed;
  final double scaling;
  final double movementSpeed;

  AnimatedImageContainer(
      this.opacity, this.rotationSpeed, this.scaling, this.movementSpeed,
      {super.key, required AnimationController controller})
      : super(listenable: controller);

  final double left = math.Random().nextDouble();
  final double bottom = math.Random().nextDouble();

  Animation<double> get _progress => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: left * MediaQuery.of(context).size.width,
        bottom: bottom * MediaQuery.of(context).size.height,
        child: Transform.scale(
            scale: 1 + (_progress.value * scaling),
            child: Transform.rotate(
              angle: _progress.value * 2.0 * math.pi * rotationSpeed,
              child: SizedBox(
                width: 50,
                child: Image.asset('assets/images2/logo.png',
                    opacity: AlwaysStoppedAnimation(opacity)),
              ),
            )));
  }

  double calcAngle(double oldAngle) {
    return 0.0;
  }
}

class AnimatedImageExample extends StatefulWidget {
  final bool enableOpacity;
  final bool enableRotation;
  final bool enableMovement;
  final bool enableScaling;

  const AnimatedImageExample(
      {super.key,
      required this.enableOpacity,
      required this.enableRotation,
      required this.enableMovement,
      required this.enableScaling});

  @override
  State<AnimatedImageExample> createState() => _AnimatedImageExampleState();
}

class _AnimatedImageExampleState extends State<AnimatedImageExample>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 10),
    vsync: this,
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double opacity = 1.0;
    double rotationSpeed = 0.0;
    double scaling = 0.0;
    double movementSpeed = 0.0;
    if (widget.enableOpacity) {
      opacity = math.Random().nextDouble();
    }
    if (widget.enableRotation) {
      rotationSpeed = (math.Random().nextDouble() - math.Random().nextDouble()) * 8;
    }
    if (widget.enableScaling) {
      scaling = math.Random().nextDouble() * 10;
    }
    if (widget.enableMovement) {
      movementSpeed = math.Random().nextDouble();
    }
    return AnimatedImageContainer(
        opacity, rotationSpeed, scaling, movementSpeed,
        controller: _controller);
  }
}