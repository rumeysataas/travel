import 'package:flutter/material.dart';

const double appDefaultPadding = 30;

const Color appBlue = Color(0xff006994);

final appOutlineInputBorder = OutlineInputBorder(
    borderSide: BorderSide(color: appBlue),
    borderRadius: BorderRadius.circular(12));

ThemeData customTheme = ThemeData(
    appBarTheme: AppBarTheme(
      centerTitle: true,
    ),
    primaryColor: Colors.blue[800],
    inputDecorationTheme: InputDecorationTheme(
        filled: true,
        labelStyle: TextStyle(fontSize: 18),
        enabledBorder: appOutlineInputBorder,
        focusedBorder: appOutlineInputBorder),
    textTheme: TextTheme(
      headline1: TextStyle(color: Colors.black),
      headline2: TextStyle(color: Colors.black),
      headline3: TextStyle(color: Colors.black),
      headline4: TextStyle(color: Colors.black),
      headline5: TextStyle(color: Colors.black),
      headline6: TextStyle(color: Colors.black),
    ));
