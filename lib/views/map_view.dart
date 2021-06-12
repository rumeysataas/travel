import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel/widgets/app_map_place.dart';
import '../custom_theme.dart';
import '../extensions/context_extensions.dart';

class MapView extends StatefulWidget {
  MapView({Key? key}) : super(key: key);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          GoogleMap(
            mapType: MapType.hybrid,
            initialCameraPosition: CameraPosition(
                bearing: 192.8334901395799,
                target: LatLng(37.43296265331129, -122.08832357078792),
                tilt: 59.440717697143555,
                zoom: 19.151926040649414),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.symmetric(
                  vertical: context.phoneHeight * .15, horizontal: 20),
              height: context.phoneHeight * 0.15,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  AppMapPlace(),
                  AppMapPlace(),
                  AppMapPlace(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
