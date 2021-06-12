import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel/core/router_manager.dart';
import 'package:travel/custom_theme.dart';
import 'package:travel/services/auth_service.dart';
import 'package:travel/services/state/user_state.dart';
import 'package:travel/utils/utils.dart';
import 'package:travel/views/sign_up_view.dart';
import 'package:travel/widgets/base/auth_base.dart';
import '../extensions/context_extensions.dart';

final UserState loginState = UserState();

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AuthBase(children: [
      SizedBox(height: context.phoneHeight * .1),
      _AppHeader(),
      SizedBox(height: context.phoneHeight * .05),
      _AppForm(formKey: this.loginFormKey),
      SizedBox(height: context.phoneHeight * .05),
      _AppLogin(
        formKey: this.loginFormKey,
      ),
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
                onPressed: () {
                  RouteManager.newPage(SignUpView());
                },
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
  final GlobalKey<FormState> formKey;
  const _AppForm({Key? key, required this.formKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: this.formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            validator: (String? val) {
              if (val!.isEmpty) {
                return "Lütfen e-posta adresinizi belirtin";
              }
              if (!Utils.controlMail(val)) {
                return "E-posta formatınızı hatalı girdiniz";
              }
              return null;
            },
            onSaved: (String? val) {
              loginState.setEmail = val;
            },
            decoration: InputDecoration(
                labelText: 'E-posta adresiniz',
                prefixIcon: Icon(FontAwesomeIcons.mailBulk)),
          ),
          SizedBox(height: 10),
          TextFormField(
            obscureText: true,
            onSaved: (String? val) {
              loginState.setPassword = val;
            },
            validator: (String? val) {
              if (val!.length < 9) {
                return "Lütfen şifreniz için en az 9 karakter girin";
              }
              return null;
            },
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
  final GlobalKey<FormState> formKey;
  const _AppLogin({Key? key, required this.formKey}) : super(key: key);

  _login() {
    if (this.formKey.currentState!.validate()) {
      this.formKey.currentState!.save();
      AuthService.instance.signIn(loginState.email, loginState.password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                primary: context.primaryColor,
                padding: const EdgeInsets.all(appDefaultPadding - 10)),
            onPressed: _login,
            child: Text('Giriş Yap',
                style: context.textTheme.headline6!
                    .copyWith(color: Colors.white))));
  }
}
