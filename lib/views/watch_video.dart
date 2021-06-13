import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WatchVideo extends StatelessWidget {
  const WatchVideo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    return Scaffold(
      appBar: AppBar(
        title: Text('watch'),
      ),
    );
  }
}
