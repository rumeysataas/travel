import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel/core/router_manager.dart';
import 'package:travel/custom_theme.dart';
import 'package:travel/services/places.dart';
import 'package:travel/utils/utils.dart';
import 'package:travel/views/map_view.dart';
import 'package:travel/views/search_place.dart';
import 'package:travel/views/search_video.dart';
import 'package:travel/views/update_user_info_view.dart';
import 'package:travel/views/user_settings.dart';
import 'package:travel/widgets/app_advice_card.dart';
import 'package:travel/widgets/app_card.dart';
import 'package:travel/widgets/menu.dart';
import '../extensions/context_extensions.dart';
import '../extensions/string_extensions.dart';

class HomeView extends StatefulWidget {
  final bool updateLocation;
  const HomeView({Key? key, this.updateLocation = true}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      RouteManager.initializeRoute(context);
      Utils.enableLocationPermission(updateLocation: widget.updateLocation);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(context.currentUser?.name);
    print(MediaQuery.of(context).size.width);
    return Scaffold(
      key: scaffoldKey,
      drawer: Menu(),
      body: SafeArea(child: LayoutBuilder(
        builder: (_, constraints) {
          print(constraints);
          if (constraints.maxWidth <= 320) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      height: context.phoneHeight * .25,
                      child: _AppBar(scaffoldKey: this.scaffoldKey)),
                  Container(height: context.phoneHeight * .6, child: _Places()),
                  Container(height: context.phoneHeight * .3, child: _Advices())
                ],
              ),
            );
          } else {
            return Column(
              children: [
                Expanded(
                    flex: 1, child: _AppBar(scaffoldKey: this.scaffoldKey)),
                Expanded(flex: 3, child: _Places()),
                Expanded(flex: 1, child: _Advices())
              ],
            );
          }
        },
      )),
    );
  }
}

class _AppBar extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const _AppBar({Key? key, required this.scaffoldKey}) : super(key: key);

  void openSearch() {
    RouteManager.showSearchDelagate(SearchPlace());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: IconButton(
            icon: Icon(FontAwesomeIcons.bars),
            onPressed: () {
              this.scaffoldKey.currentState?.openDrawer();
            },
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(
                color: Color(0xffdedede),
                borderRadius: BorderRadius.circular(100)),
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: InkWell(
              onTap: this.openSearch,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(FontAwesomeIcons.search,
                          color: context.primaryColor),
                      SizedBox(width: 20),
                      Text(
                        'Yer arayın',
                        style: context.textTheme.headline6!
                            .copyWith(fontWeight: FontWeight.normal),
                      )
                    ],
                  ),
                  Icon(FontAwesomeIcons.locationArrow,
                      color: context.primaryColor)
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _Places extends StatelessWidget {
  const _Places({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: appDefaultPadding, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Yerler...',
            style: context.textTheme.headline5
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                AppCard(
                  imageUrl: 'restaurant.svg',
                  title: 'Restoranlar',
                  subtitle: 'Güzel Lezzetler',
                  onTap: () {
                    RouteManager.newPage(MapView());
                    Places.instance.filterNearbyPlaces('restaurant');
                  },
                ),
                AppCard(
                  imageUrl: 'bar.svg',
                  title: 'Bar ve Kafeler',
                  subtitle: 'Biraz Eğlence!',
                  onTap: () {
                    RouteManager.newPage(MapView());
                    Places.instance.filterNearbyPlaces('bar');
                  },
                ),
                AppCard(
                  imageUrl: 'hotel.svg',
                  title: 'Konaklama',
                  subtitle: 'Kalınacak Yerler',
                  onTap: () {
                    RouteManager.newPage(MapView());
                    Places.instance.filterNearbyPlaces('otel');
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Advices extends StatelessWidget {
  const _Advices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: appDefaultPadding, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Tavsiyeler',
            style: context.textTheme.headline5
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Expanded(
            child: Row(
              children: [
                AppAdviceCard(
                    icon: FontAwesomeIcons.placeOfWorship,
                    title: 'Yakında neler var?',
                    onTap: () {
                      RouteManager.newPage(MapView());
                      Places.instance.findNearbyPlaces();
                    }),
                AppAdviceCard(
                    icon: FontAwesomeIcons.youtube,
                    title: 'Videolar',
                    onTap: () {
                      RouteManager.newPage(SearchVideo());
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
