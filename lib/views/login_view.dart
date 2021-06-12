import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel/core/router_manager.dart';
import 'package:travel/custom_theme.dart';
import 'package:travel/views/sign_up_view.dart';
import 'package:travel/widgets/base/auth_base.dart';
import '../extensions/context_extensions.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthBase(children: [
      SizedBox(height: context.phoneHeight * .1),
      _AppHeader(),
      SizedBox(height: context.phoneHeight * .05),
      _AppForm(),
      SizedBox(height: context.phoneHeight * .05),
      _AppLogin(),
    ]);
  }
}

class _AppHeader extends StatelessWidget {
  const _AppHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text('Yeni misiniz? /', style: context.textTheme.subtitle1),
            TextButton(
                onPressed: () {},
                child: Text(
                  'Hesap Oluşturun',
                  style:
                      context.textTheme.subtitle1!.copyWith(color: Colors.blue),
                ))
          ],
        )
      ],
    );
  }
}

class _AppForm extends StatelessWidget {
  const _AppForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
                labelText: 'E-posta adresiniz',
                prefixIcon: Icon(FontAwesomeIcons.mailBulk)),
          ),
          SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
                labelText: 'Şifreniz',
                prefixIcon: Icon(FontAwesomeIcons.userLock)),
          ),
        ],
      ),
    );
  }
}

class _AppLogin extends StatelessWidget {
  const _AppLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                primary: context.primaryColor,
                padding: const EdgeInsets.all(appDefaultPadding - 10)),
            onPressed: () {},
            child: Text('Giriş Yap',
                style: context.textTheme.headline6!
                    .copyWith(color: Colors.white))));
  }
}
