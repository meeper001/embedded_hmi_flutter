import 'package:embedded_hmi_flutter/performance_test/animation_performance.dart';
import 'package:embedded_hmi_flutter/performance_test/finger_painter.dart';
import 'package:embedded_hmi_flutter/performance_test/multitouch.dart';
import 'package:embedded_hmi_flutter/performance_test/video.dart';
import 'package:flutter/material.dart';
import 'package:embedded_hmi_flutter/performance_test/pinch_to_zoom.dart';
import 'package:media_kit/media_kit.dart';
import 'package:touch_indicator/touch_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:statsfl/statsfl.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Necessary initialization for package:media_kit.
  MediaKit.ensureInitialized();
  runApp(StatsFl(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'SMD Raspberry Test',
        builder: (context, child) => TouchIndicator(
              forceInReleaseMode: true,
              child: child!,
            ),
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
            useMaterial3: true,
            fontFamily: "Poppins",
            textTheme: const TextTheme(
                titleLarge: TextStyle(fontSize: 38.0),
                displayLarge: TextStyle(fontSize: 38.0),
                labelLarge:
                    TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700))),
        home:  const TouchIndicator(
                child: MyHomePage(
              title: 'Embedded HMI Flutter',
            )));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final double iconHeight = 120.0;
  final Color colorPeople = const Color(0xccf05a96);
  final Color colorCode = const Color(0xcc6ed2f0);
  final Color colorCommitment = const Color(0xcc82c864);
  final Radius buttonRadius = const Radius.circular(25);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.fitWidth,
          image: AssetImage("assets/images/background.png"),
        )),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(buttonRadius)),
                    color: colorPeople,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MultiTouch()),
                      );
                    },
                    child: SizedBox(
                        width: MediaQuery.of(context).size.height * 0.4,
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              LayoutBuilder(builder: (context, constraints) {
                                return Icon(
                                  Icons.pinch,
                                  size: constraints.maxWidth * 0.4,
                                );
                              }),
                              const Text("Multitouch")
                            ]))),
                MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(buttonRadius)),
                    color: colorCode,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PinchToZoom()),
                      );
                    },
                    child: SizedBox(
                        width: MediaQuery.of(context).size.height * 0.4,
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              LayoutBuilder(builder: (context, constraints) {
                                return SvgPicture.asset(
                                  "assets/icons/gesture-two-double-tap.svg",
                                  height: constraints.maxWidth * 0.4,
                                );
                              }),
                              const Text("Gestures"),
                            ]))),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(buttonRadius)),
                  color: colorCommitment,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AnimationPerformance()),
                    );
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.height * 0.4,
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LayoutBuilder(builder: (context, constraints) {
                            return SvgPicture.asset(
                              "assets/icons/animation-outline.svg",
                              height: constraints.maxWidth * 0.4,
                            );
                          }),
                          const Text("Animation"),
                        ]),
                  ),
                ),
              ]),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(buttonRadius)),
                color: colorPeople,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FingerPainter()),
                  );
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.height * 0.4,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LayoutBuilder(builder: (context, constraints) {
                          return SvgPicture.asset(
                            'assets/icons/cursor-default-gesture.svg',
                            height: constraints.maxWidth * 0.4,
                          );
                        }),
                        const Text("Labyrinth")
                      ]),
                ),
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(buttonRadius)),
                color: colorCode,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const VideoTest()),
                  );
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.height * 0.4,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LayoutBuilder(builder: (context, constraints) {
                          return SvgPicture.asset(
                            'assets/icons/movie-play.svg',
                            height: constraints.maxWidth * 0.4,
                          );
                        }),
                        const Text("Videoplayer")
                      ]),
                ),
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(buttonRadius)),
                color: colorCommitment,
                onPressed: () {},
                child: SizedBox(
                  width: MediaQuery.of(context).size.height * 0.4,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LayoutBuilder(builder: (context, constraints) {
                          return SvgPicture.asset(
                            "assets/icons/mw-logo-black-text.svg",
                            height: constraints.maxWidth * 0.4,
                          );
                        }),
                      ]),
                ),
              ),
            ],
          )
        ]),
      ),
    ));
  }
}
