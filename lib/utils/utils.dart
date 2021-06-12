import 'package:geolocator/geolocator.dart';
import 'package:travel/core/router_manager.dart';
import 'package:travel/services/places.dart';
import '../views/ask_permission.dart';

class Utils {
  static controlMail(String text) {
    if (RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(text)) {
      return true;
    } else {
      return false;
    }
  }

  static enableLocationPermission({bool updateLocation = true}) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      RouteManager.newPage(AskPermission());
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        RouteManager.newPage(AskPermission());
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition();
    if (updateLocation) {
      Places.instance.currentPosition = {
        'lat': position.latitude,
        'lng': position.longitude
      };
      print(Places.instance.currentPosition);
      print('location updated');
    } else {
      print('no update!');
    }
  }
}
