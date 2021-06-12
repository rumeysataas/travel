import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel/core/router_manager.dart';
import 'package:travel/custom_theme.dart';
import 'package:travel/views/map_view.dart';
import 'package:travel/widgets/app_advice_card.dart';
import 'package:travel/widgets/app_card.dart';
import '../extensions/context_extensions.dart';
import '../extensions/string_extensions.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      RouteManager.initializeRoute(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(context.currentUser?.name);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [_AppBar(), _Places(), _Advices()],
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Column(
          children: [
            ListTile(
              onTap: () {},
              leading: CircleAvatar(
                radius: 30,
              ),
              title: Text('Welcome', style: context.textTheme.subtitle1),
              subtitle: Text('${context.currentUser?.name?.capitalize}',
                  style: context.textTheme.headline5),
              trailing:
                  Icon(FontAwesomeIcons.cogs, color: context.primaryColor),
            ),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: appDefaultPadding),
                decoration: BoxDecoration(
                    color: Color(0xffdedede),
                    borderRadius: BorderRadius.circular(100)),
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
            )
          ],
        ));
  }
}

class _Places extends StatelessWidget {
  const _Places({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 3,
        child: Padding(
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
                      },
                    ),
                    AppCard(
                      imageUrl: 'bar.svg',
                      title: 'Gece Kulüpleri',
                      subtitle: 'Biraz Eğlence!',
                      onTap: () {},
                    ),
                    AppCard(
                      imageUrl: 'hotel.svg',
                      title: 'Konaklama',
                      subtitle: 'Kalınacak Yerler',
                      onTap: () {},
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class _Advices extends StatelessWidget {
  const _Advices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Padding(
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
                        onTap: () {}),
                    AppAdviceCard(
                        icon: FontAwesomeIcons.youtube,
                        title: 'Videolar',
                        onTap: () {}),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
