import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteManager {
  static var routeContext;

  static initializeRoute(BuildContext context) {
    routeContext = context;
  }

  static newPage(Widget view) {
    Navigator.of(routeContext)
        .push(MaterialPageRoute(builder: (routeContext) => view));
  }

  static backPage() {
    Navigator.of(routeContext).pop();
  }

  static showErrorDialog() {
    showDialog(context: routeContext, builder: (_) => AlertDialog());
  }
}
