import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class VideoTest extends StatefulWidget {
  const VideoTest({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VideoTestState();
}

class _VideoTestState extends State<VideoTest> {
  late final player = Player();
  late final controller = VideoController(player);

  @override
  void initState() {
    super.initState();
    player.open(Media(
        'https://user-images.githubusercontent.com/28951144/229373695-22f88f13-d18f-4288-9bf1-c3e078d83722.mp4'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Video Performance"),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Center(
            child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width * 9.0 / 16.0,
          // Use [Video] widget to display video output.
          child: Video(
            controller: controller,
            controls: AdaptiveVideoControls,
          ),
        )));
  }

  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }
}
