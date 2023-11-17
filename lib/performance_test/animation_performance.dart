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
  int maxImages = 400;
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
      body: Stack(children: imagesList + [controls(context)]),
    );
  }

  Widget controls(BuildContext context) {
    return Positioned(
        top: 20,
        left: 20,
        child: Container(
            width: MediaQuery.of(context).size.width / 3,
            height: MediaQuery.of(context).size.height / 3,
            decoration: BoxDecoration(border: Border.all()),
            child: FittedBox(
              alignment: Alignment.topLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Slider(
                      value: numberOfImages,
                      label: numberOfImages.round().toString(),
                      min: 1,
                      max: maxImages.toDouble(),
                      divisions: maxImages - 1,
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
            )));
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
  final bool enableMovement;

  AnimatedImageContainer(
      this.opacity, this.rotationSpeed, this.scaling, this.enableMovement,
      {super.key, required AnimationController controller})
      : super(listenable: controller);

  double left = math.Random().nextDouble();
  double bottom = math.Random().nextDouble();

  Animation<double> get _progress => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    Duration duration =
        Duration(milliseconds: math.Random().nextInt(4000) + 500);
    if (!enableMovement) {
      duration = Duration.zero;
    }
    return AnimatedPositioned(
        left: left * MediaQuery.of(context).size.width,
        bottom: bottom * MediaQuery.of(context).size.height,
        duration: duration,
        onEnd: () {
          if (enableMovement) {
            left = math.Random().nextDouble();
            bottom = math.Random().nextDouble();
          }
        },
        child: Transform.scale(
            scale: 1 + (_progress.value * scaling),
            child: Transform.rotate(
              angle: _progress.value * 2.0 * math.pi * rotationSpeed,
              child: SizedBox(
                width: 50,
                child: Image.asset('assets/images/logo.png',
                    opacity: AlwaysStoppedAnimation(opacity)),
              ),
            )));
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

  double width = 0.0;
  double height = 0.0;

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
    if (widget.enableOpacity) {
      opacity = math.Random().nextDouble();
    }
    if (widget.enableRotation) {
      rotationSpeed =
          (math.Random().nextDouble() - math.Random().nextDouble()) * 8;
    }
    if (widget.enableScaling) {
      scaling = math.Random().nextDouble() * 10;
    }
    return AnimatedImageContainer(
        opacity, rotationSpeed, scaling, widget.enableMovement,
        controller: _controller);
  }
}
