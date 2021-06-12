import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:travel/custom_theme.dart';
import 'package:travel/views/login_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: customTheme,
      title: 'Travel',
      home: LoginView(),
    );
  }
}