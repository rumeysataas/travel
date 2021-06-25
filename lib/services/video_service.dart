import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:travel/constants/constants.dart';
import 'package:travel/models/VideoModel.dart';


//video listeleme için kullanacağımız sınıf
class VideoService extends ChangeNotifier {
  VideoService._privateConstructor();
  static final VideoService _instance = VideoService._privateConstructor();
  static VideoService get instance => _instance;

  //video listemiz
  List<VideoModel> videos = [];

  listVideos({String query = 'gezilesiyer'}) async {
    videos = [];
    final result = await http.get(Uri.parse(
        'https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=20&q=$query&type=video&key=$apiKey')); //google servisinden dönen sonuç
    final json = jsonDecode(result.body);
    List items = json['items'];
    videos = items.map((video) => VideoModel.fromJson(video)).toList();   //sonucu listeye aktar
    notifyListeners();
  }
}
