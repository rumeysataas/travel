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

  static newPageReplacement(Widget view) {
    Navigator.of(routeContext)
        .pushReplacement(MaterialPageRoute(builder: (routeContext) => view));
  }

  static backPage() {
    Navigator.of(routeContext).pop();
  }

  static showErrorDialog(String errorText) {
    showDialog(
        context: routeContext,
        builder: (_) => AlertDialog(
              title: Text('Ups 🙄'),
              content: Text(errorText),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      RouteManager.backPage();
                    },
                    child: Text('Geri Dön'))
              ],
            ));
  }

  static showSearchDelagate(SearchDelegate delegate) {
    showSearch(context: routeContext, delegate: delegate);
  }
}
