import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: customTheme,
      title: 'Travel',
      home: SplashView(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }
}
