import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:travel/models/PlaceModel.dart';
import '../constants/constants.dart';

class Places extends ChangeNotifier {
  Places._privateConstructor();
  static final Places _instance = Places._privateConstructor();
  static Places get instance => _instance;

  //kullanıcının konumu için kullanacağımız objemiz
  Map currentPosition = {'lat': 0, 'lng': 0};

  List<PlaceModel> nearbyPlaces = [];
  List<PlaceModel> searchResults = [];

  findNearbyPlaces() async {
    //yakın yerler apiden konuma göre dönen sonuçlar
    print(currentPosition);
    final String nearbyPlacesAPI =
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${currentPosition['lat']},${currentPosition['lng']}&radius=4500&key=$apiKey";
    List results = await _sendRequest(nearbyPlacesAPI);
    nearbyPlaces =
        results.map((result) => PlaceModel.fromJson(result)).toList();
    notifyListeners();
  }

  filterNearbyPlaces(String type) async {
    //yakın yerleri filtrelemek
    //apiden dönen sonuçlar
    print(currentPosition);
    final String searchNearbyAPI =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${currentPosition['lat']},${currentPosition['lng']}&radius=1500&type=$type&key=$apiKey';
    List results = await _sendRequest(searchNearbyAPI);
    nearbyPlaces =
        results.map((result) => PlaceModel.fromJson(result)).toList();
    notifyListeners();
  }

  searchPlace(String place) async {
    //mekan arama
    //apiden dönen sonuçlara göre mekan arama
    print(currentPosition);
    searchResults = [];
    final String searchNearbyAPI =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${currentPosition['lat']},${currentPosition['lng']}&radius=1500&name=$place&key=$apiKey';
    List result = await _sendRequest(searchNearbyAPI);
    searchResults =
        result.map((result) => PlaceModel.fromJson(result)).toList();
    notifyListeners();
  }

  //istek göndermek için sadece bu sınıfta kullanacağımız fonksiyon
  _sendRequest(String endpoint) async {
    final result = await http.get(Uri.parse(endpoint));
    final json = jsonDecode(result.body);
    List results = json['results'];
    return results;
  }
}
