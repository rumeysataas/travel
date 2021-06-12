import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:travel/custom_theme.dart';
import 'package:travel/views/splash_view.dart';

import 'core/storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Storage.initialStorage();
  if (Storage.getString('mapType') == null) {
    Storage.saveString('mapType', 'Normal');
    print(Storage.getString('mapType'));
  }
  runApp(DevicePreview(
    enabled: true,
    builder: (context) => MyApp(), // Wrap your app
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context), // Add the locale here
      builder: DevicePreview.appBuilder, // Add the builder here
      theme: customTheme,
      title: 'Travel',
      home: SplashView(),
    );
  }
}
