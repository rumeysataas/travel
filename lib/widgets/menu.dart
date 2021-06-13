import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel/core/router_manager.dart';
import 'package:travel/services/places.dart';
import 'package:travel/views/map_view.dart';
import 'package:travel/views/search_place.dart';
import 'package:travel/views/search_video.dart';
import 'package:travel/views/update_user_info_view.dart';
import 'package:travel/views/user_settings.dart';
import '../extensions/context_extensions.dart';
import '../extensions/string_extensions.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30,
                  child: Text('${context.currentUser?.name?.avatarValue}',
                      style: context.textTheme.headline5),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${context.currentUser?.name}',
                      style: context.textTheme.headline5!
                          .copyWith(color: Colors.white),
                    ),
                    Text(
                      '${context.currentUser?.email}',
                      style: context.textTheme.headline6!
                          .copyWith(color: Colors.white),
                    )
                  ],
                )
              ],
            )),
        ListTile(
          leading: Icon(Icons.location_on, color: context.primaryColor),
          title: Text('Nasıl Giderim?'),
          onTap: () {
            RouteManager.showSearchDelagate(SearchPlace());
          },
        ),
        ListTile(
          leading: Icon(Icons.location_city, color: context.primaryColor),
          title: Text('Size Yakın Yerler'),
          onTap: () {
            RouteManager.newPage(MapView());
            Places.instance.findNearbyPlaces();
          },
        ),
        ListTile(
          leading: Icon(Icons.restaurant, color: context.primaryColor),
          title: Text('Restaurant'),
          onTap: () {
            RouteManager.newPage(MapView());
            Places.instance.filterNearbyPlaces('restaurant');
          },
        ),
        ListTile(
          leading: Icon(Icons.nightlife, color: context.primaryColor),
          title: Text('Bar'),
          onTap: () {
            RouteManager.newPage(MapView());
            Places.instance.filterNearbyPlaces('bar');
          },
        ),
        ListTile(
          leading: Icon(FontAwesomeIcons.bed, color: context.primaryColor),
          title: Text('Konaklama'),
          onTap: () {
            RouteManager.newPage(MapView());
            Places.instance.filterNearbyPlaces('otel');
          },
        ),
        ListTile(
          leading: Icon(FontAwesomeIcons.youtube, color: context.primaryColor),
          title: Text('Video Araması'),
          onTap: () {
            RouteManager.newPage(SearchVideo());
          },
        ),
        ListTile(
          leading: Icon(FontAwesomeIcons.cogs, color: context.primaryColor),
          title: Text('Ayarlar'),
          onTap: () {
            RouteManager.newPage(UserSettings());
          },
        ),
        ListTile(
          leading: Icon(FontAwesomeIcons.user, color: context.primaryColor),
          title: Text('Kullanıcı Profili'),
          onTap: () {
            RouteManager.newPage(UpdateUserInfoView());
          },
        ),
      ],
    ));
  }
}
