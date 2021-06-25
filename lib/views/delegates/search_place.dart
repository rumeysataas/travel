import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel/core/storage.dart';
import 'package:travel/custom_theme.dart';
import 'package:travel/models/PlaceModel.dart';
import 'package:travel/services/places.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../extensions/string_extensions.dart';

class SearchPlace extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return Icon(FontAwesomeIcons.mapMarked);
  }

  @override
  Widget buildResults(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    //yeni arama sorgusu oluşturup arama geçmişine kayıt
    if (Storage.getList('search') == null) {
      print('new created!');
      Storage.saveList('search', []);
    }

    List<String> searchLog = Storage.getList('search');
    searchLog.insert(0, query);
    Storage.saveList('search', searchLog);
    Places.instance.searchPlace(query);
    return Padding(
      padding: const EdgeInsets.all(appDefaultPadding),
      child: AnimatedBuilder(
          animation: Places.instance,
          builder: (context, snapshot) {
            return ListView.builder(
              itemCount: Places.instance.searchResults.length,
              itemBuilder: (_, index) {
                PlaceModel place = Places.instance.searchResults[index];
                return ListTile(
                  onTap: () async {
                    String url = "https://www.google.com/maps/dir/?api=1&origin=" +
                        '${Places.instance.currentPosition['lat']},${Places.instance.currentPosition['lng']}' +
                        "&destination=" +
                        "${place.location['lat']},${place.location['lng']}" +
                        "&travelmode=driving&dir_action=navigate";
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  leading: Container(
                      height: 30, width: 30, child: Image.network(place.icon)),
                  title: Text(place.name),
                  subtitle: Text(place.vicinity),
                  trailing: Icon(FontAwesomeIcons.handPointRight),
                );
              },
            );
          }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    print(Storage.getList('search'));
    return Padding(
      padding: const EdgeInsets.all(appDefaultPadding),
      child: ListView.builder(
        itemCount: Storage.getList('search') != null
            ? (Storage.getList('search') as List<String>).length
            : 0,
        itemBuilder: (_, index) {
          final String log = Storage.getList('search') != null
              ? (Storage.getList('search') as List<String>)[index]
              : '';
          return ListTile(
            onTap: () {
              query = log;
            },
            title: Text(log.capitalize),
            trailing:
            Icon(FontAwesomeIcons.searchLocation),
          );
        },
      ),
    );
  }
}
