import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel/core/router_manager.dart';
import 'package:travel/custom_theme.dart';
import 'package:travel/services/places.dart';
import 'package:travel/utils/utils.dart';
import 'package:travel/views/home_view.dart';
import '../extensions/context_extensions.dart';

class ChangeCity extends StatelessWidget {
  const ChangeCity({Key? key}) : super(key: key);

  Future<List> loadCities() async {
    var cities = await rootBundle.loadString('assets/json/cities.json');
    return jsonDecode(cities);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return Scaffold(
      appBar: AppBar(
        title: Text('Şehir Değiştir'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(appDefaultPadding),
        child: FutureBuilder<List>(
          future: loadCities(),
          builder: (_, snapshot) {
            int totalItem = 81;
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: totalItem,
                    itemBuilder: (_, index) => index == 0
                        ? Container(
                            color: context.primaryColor,
                            child: ListTile(
                              onTap: () {
                                Utils.enableLocationPermission();
                                RouteManager.newPage(HomeView());
                              },
                              title: Text('Kendi Konumumu Kullan',
                                  style: context.textTheme.headline6!
                                      .copyWith(color: Colors.white)),
                              trailing: Icon(Icons.location_city,
                                  color: Colors.white),
                            ),
                          )
                        : ListTile(
                            onTap: () {
                              Places.instance.currentPosition = {
                                "lat": double.parse(
                                    snapshot.data?[index]['latitude']),
                                "lng": double.parse(
                                    snapshot.data?[index]['longitude']),
                              };
                              print('new' +
                                  Places.instance.currentPosition.toString());
                              RouteManager.newPage(
                                  HomeView(updateLocation: false));
                            },
                            title: Text('${snapshot.data?[index]['name']}'),
                            subtitle:
                                Text('${snapshot.data?[index]['region']}'),
                            trailing: Icon(FontAwesomeIcons.check),
                          ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }
}
