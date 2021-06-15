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

  static turkeyProvinces() {
    List<String> provinces = [
      "Adana",
      "Adıyaman",
      "Afyon",
      "Ağrı",
      "Amasya",
      "Ankara",
      "Antalya",
      "Artvin",
      "Aydın",
      "Balıkesir",
      "Bilecik",
      "Bingöl",
      "Bitlis",
      "Bolu",
      "Burdur",
      "Bursa",
      "Çanakkale",
      "Çankırı",
      "Çorum",
      "Denizli",
      "Diyarbakır",
      "Edirne",
      "Elazığ",
      "Erzincan",
      "Erzurum",
      "Eskişehir",
      "Gaziantep",
      "Giresun",
      "Gümüşhane",
      "Hakkari",
      "Hatay",
      "Isparta",
      "Mersin",
      "İstanbul",
      "İzmir",
      "Kars",
      "Kastamonu",
      "Kayseri",
      "Kırklareli",
      "Kırşehir",
      "Kocaeli",
      "Konya",
      "Kütahya",
      "Malatya",
      "Manisa",
      "Kahramanmaraş",
      "Mardin",
      "Muğla",
      "Muş",
      "Nevşehir",
      "Niğde",
      "Ordu",
      "Rize",
      "Sakarya",
      "Samsun",
      "Siirt",
      "Sinop",
      "Sivas",
      "Tekirdağ",
      "Tokat",
      "Trabzon",
      "Tunceli",
      "Şanlıurfa",
      "Uşak",
      "Van",
      "Yozgat",
      "Zonguldak",
      "Aksaray",
      "Bayburt",
      "Karaman",
      "Kırıkkale",
      "Batman",
      "Şırnak",
      "Bartın",
      "Ardahan",
      "Iğdır",
      "Yalova",
      "Karabük",
      "Kilis",
      "Osmaniye",
      "Düzce"
    ];
    return provinces;
  }
}
