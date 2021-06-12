import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteManager {
  static BuildContext? routeContext;

  static initializeRoute(BuildContext context) {
    routeContext = context;
  }

  static newPage(Widget view) {
    Navigator.of(routeContext)
        .push(MaterialPageRoute(builder: (routeContext) => view));
  }
}
