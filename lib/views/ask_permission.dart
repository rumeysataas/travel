import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travel/custom_theme.dart';
import 'package:travel/utils/utils.dart';
import '../extensions/context_extensions.dart';

class AskPermission extends StatelessWidget {
  const AskPermission({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Konum İzni'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(appDefaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: Text(
                'Konum iznine ihtiyacımız var',
                textAlign: TextAlign.center,
                style: context.textTheme.headline5
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: SvgPicture.asset(
                'assets/images/ask-permission.svg',
              ),
            ),
            Center(
              child: Text(
                'Uygulamamızı kullanmak için lütfen konum servislerini açar mısınız?',
                textAlign: TextAlign.center,
                style: context.textTheme.headline5,
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: context.primaryColor,
                    shape: StadiumBorder(),
                    padding: const EdgeInsets.symmetric(
                        horizontal: appDefaultPadding, vertical: 15)),
                onPressed: () {
                  Utils.enableLocationPermission();
                },
                child: Text('İzin Ver'))
          ],
        ),
      ),
    );
  }
}
