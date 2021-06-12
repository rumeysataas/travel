import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel/core/router_manager.dart';
import 'package:travel/services/auth_service.dart';
import 'package:travel/views/login_view.dart';

class SplashView extends StatefulWidget {
  SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    RouteManager.initializeRoute(context);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (FirebaseAuth.instance.currentUser != null) {
        AuthService.instance.autoLogin();
      } else {
        RouteManager.newPage(LoginView());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
