import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel/services/places.dart';
import 'package:travel/widgets/app_map_place.dart';
import '../custom_theme.dart';
import '../extensions/context_extensions.dart';

class MapView extends StatefulWidget {
  MapView({Key? key}) : super(key: key);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  Completer<GoogleMapController> _controller = Completer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AnimatedBuilder(
            animation: Places.instance,
            builder: (context, snapshot) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  GoogleMap(
                    myLocationButtonEnabled: true,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    myLocationEnabled: true,
                    mapType: MapType.normal,
                    markers: Places.instance.nearbyPlaces
                        .map(
                          (place) => Marker(
                              markerId: MarkerId(place.name),
                              position: LatLng(
                                  place.location['lat'], place.location['lng']),
                              infoWindow: InfoWindow(title: place.name)),
                        )
                        .toSet(),
                    initialCameraPosition: CameraPosition(
                        target: LatLng(Places.instance.currentPosition['lat'],
                            Places.instance.currentPosition['lng']),
                        zoom: 19.151926040649414),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                        margin: EdgeInsets.symmetric(
                            vertical: context.phoneHeight * .15,
                            horizontal: 20),
                        height: context.phoneHeight * 0.15,
                        width: double.infinity,
                        child: ListView.builder(
                          itemCount: Places.instance.nearbyPlaces.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) => AppMapPlace(
                              onTap: () async {
                                final GoogleMapController controller =
                                    await _controller.future;
                                controller.animateCamera(
                                    CameraUpdate.newCameraPosition(
                                  CameraPosition(
                                      target: LatLng(
                                          Places.instance.nearbyPlaces[index]
                                              .location['lat'],
                                          Places.instance.nearbyPlaces[index]
                                              .location['lng']),
                                      zoom: 19.151926040649414),
                                ));
                              },
                              placeModel: Places.instance.nearbyPlaces[index]),
                        )),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
