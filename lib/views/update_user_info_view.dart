import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel/core/router_manager.dart';
import 'package:travel/custom_theme.dart';
import 'package:travel/services/auth_service.dart';
import 'package:travel/utils/utils.dart';
import '../extensions/context_extensions.dart';

class UpdateUserInfoView extends StatefulWidget {
  const UpdateUserInfoView({Key? key}) : super(key: key);

  @override
  _UpdateUserInfoViewState createState() => _UpdateUserInfoViewState();
}

class _UpdateUserInfoViewState extends State<UpdateUserInfoView> {
  String name = '';
  String email = '';
  String password = '';
  final GlobalKey<FormState> formSettingsKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formSecurityKey = GlobalKey<FormState>();

  void _updateUserInfo() async {
    if (formSettingsKey.currentState!.validate()) {
      formSettingsKey.currentState!.save();
      try {
        await FirebaseAuth.instance.currentUser?.updateEmail(email);
        await FirebaseFirestore.instance
            .collection('accounts')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .update({"email": email, "name": name});
        RouteManager.showCustomDialog('Bilgileriniz güncellendi', [
          ElevatedButton(
              onPressed: () {
                AuthService.instance.logout();
              },
              child: Text('Yeniden Giriş Yap'))
        ]);
      } catch (e) {
        print(e);
        RouteManager.showErrorDialog(
            'Beklenmedik bir hata oluştu lütfen tekrar dener misiniz?');
      }
    }
  }

  void _updatePassword() async {
    if (formSecurityKey.currentState!.validate()) {
      formSecurityKey.currentState!.save();
      try {
        await FirebaseAuth.instance.currentUser?.updatePassword(password);
        RouteManager.showCustomDialog('Şifreniz güncellendi', [
          ElevatedButton(
              onPressed: () {
                AuthService.instance.logout();
              },
              child: Text('Yeniden Giriş Yap'))
        ]);
      } catch (e) {
        print(e);
        RouteManager.showErrorDialog(
            'Beklenmedik bir hata oluştu lütfen tekrar dener misiniz?');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Bilgilerimi Güncelle'),
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(appDefaultPadding),
            child: Column(
              children: [
                ExpansionTile(
                  title: Text('Genel Ayarlarınız ℹ',
                      style: context.textTheme.headline5),
                  children: [
                    Form(
                      key: formSettingsKey,
                      child: Column(
                        children: [
                          TextFormField(
                            onSaved: (String? val) {
                              if (val!.isNotEmpty) {
                                name = val;
                              }
                            },
                            validator: (String? val) {
                              if (val!.length < 3) {
                                return "Adınız Çok Kısa";
                              }
                              return null;
                            },
                            initialValue: context.currentUser?.name,
                            decoration: InputDecoration(labelText: 'Adınız'),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            onSaved: (String? val) {
                              if (val!.isNotEmpty) {
                                email = val;
                              }
                            },
                            validator: (String? val) {
                              if (val!.isEmpty) {
                                return "E-Posta adresinizi lütfen belirtin";
                              }
                              if (!Utils.controlMail(val)) {
                                return "E-posta formatınızı hatalı girdiniz";
                              }
                              return null;
                            },
                            initialValue: context.currentUser?.email,
                            decoration: InputDecoration(labelText: 'E-Posta'),
                          ),
                          SizedBox(height: 10),
                          SizedBox(height: 10),
                          Container(
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: _updateUserInfo,
                                  child: Text('Güncelle')))
                        ],
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  title:
                      Text('Güvenlik 🔐', style: context.textTheme.headline5),
                  children: [
                    Form(
                      key: formSecurityKey,
                      child: Column(
                        children: [
                          TextFormField(
                            obscureText: true,
                            onSaved: (String? val) {
                              if (val!.isNotEmpty) {
                                password = val;
                              }
                            },
                            validator: (String? val) {
                              if (val!.length < 9) {
                                return "Şifreniz en az 9 karakter içermelidir";
                              }
                              return null;
                            },
                            decoration: InputDecoration(labelText: 'Şifreniz'),
                          ),
                          Container(
                              width: double.infinity,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.red[900]),
                                  onPressed: _updatePassword,
                                  child: Text('Şifremi Değiştir')))
                        ],
                      ),
                    )
                  ],
                )
              ],
            )));
  }
}
