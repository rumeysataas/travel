import 'package:flutter/material.dart';
import 'package:travel/core/router_manager.dart';
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
      RouteManager.newPage(LoginView());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
