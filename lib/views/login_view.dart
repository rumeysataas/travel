import 'package:flutter/material.dart';
import 'package:travel/custom_theme.dart';
import '../extensions/context_extensions.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(appDefaultPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Travel',
                        style: context.textTheme.headline4!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Giriş Yapın',
                        style: context.textTheme.headline4!
                            .copyWith(fontWeight: FontWeight.w300),
                      ),
                      Wrap(
                        children: [
                          Text('Yeni misiniz? /'),
                          TextButton(
                              onPressed: () {}, child: Text('Hesap Oluşturun'))
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
