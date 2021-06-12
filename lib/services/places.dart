import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:travel/models/PlaceModel.dart';

class Places extends ChangeNotifier {
  Places._privateConstructor();
  static final Places _instance = Places._privateConstructor();
  static Places get instance => _instance;

  Map currentPosition = {'lat': 0, 'lng': 0};
  final String apiKey = 'AIzaSyBhkqWwerZVw_3CmtTzE1bloovjDydybLw';

  List<PlaceModel> nearbyPlaces = [];
  List<PlaceModel> searchResults = [];

  findNearbyPlaces() async {
    final String nearbyPlacesAPI =
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${currentPosition['lat']},${currentPosition['lng']}&radius=4500&key=$apiKey";
    List results = await _sendRequest(nearbyPlacesAPI);
    nearbyPlaces =
        results.map((result) => PlaceModel.fromJson(result)).toList();
    notifyListeners();
  }

  filterNearbyPlaces(String type) async {
    final String searchNearbyAPI =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${currentPosition['lat']},${currentPosition['lng']}&radius=1500&type=$type&key=$apiKey';
    List results = await _sendRequest(searchNearbyAPI);
    nearbyPlaces =
        results.map((result) => PlaceModel.fromJson(result)).toList();
    notifyListeners();
  }

  searchPlace(String place) async {
    searchResults = [];
    final String searchNearbyAPI =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${currentPosition['lat']},${currentPosition['lng']}&radius=1500&name=$place&key=$apiKey';
    List result = await _sendRequest(searchNearbyAPI);
    searchResults =
        result.map((result) => PlaceModel.fromJson(result)).toList();
    notifyListeners();
  }

  _sendRequest(String endpoint) async {
    final result = await http.get(Uri.parse(endpoint));
    final json = jsonDecode(result.body);
    List results = json['results'];
    return results;
  }
}
