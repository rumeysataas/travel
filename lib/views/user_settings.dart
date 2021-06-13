import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travel/core/router_manager.dart';
import 'package:travel/core/storage.dart';
import 'package:travel/views/change_city.dart';
import 'package:travel/views/login_view.dart';
import 'package:travel/views/update_user_info_view.dart';
import '../extensions/context_extensions.dart';

class UserSettings extends StatefulWidget {
  UserSettings({Key? key}) : super(key: key);

  @override
  _UserSettingsState createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Scaffold(
      appBar: AppBar(
        title: Text('Ayarlar'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            ListTile(
              title: Text('Harita Türü'),
              subtitle: DropdownButton<String>(
                value: Storage.getString('mapType'),
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    Storage.saveString('mapType', '$newValue');
                    print(Storage.getString('mapType'));
                  });
                },
                items: <String>['Normal', 'Satelitte', 'Terrain', 'Hybird']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(value, style: context.textTheme.headline5),
                    ),
                  );
                }).toList(),
              ),
            ),
            _AppUserSettingsItem(
                onTap: () {
                  RouteManager.newPage(ChangeCity());
                },
                title: 'Şehir Değiştir',
                icon: Icons.map),
            _AppUserSettingsItem(
                onTap: () {
                  RouteManager.newPage(UpdateUserInfoView());
                },
                title: 'Hesap Ayarlarım',
                icon: Icons.settings),
            _AppUserSettingsItem(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  RouteManager.newPageReplacement(LoginView());
                },
                title: 'Çıkış Yap',
                icon: Icons.logout)
          ],
        ),
      ),
    );
  }
}

class _AppUserSettingsItem extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final IconData icon;
  const _AppUserSettingsItem(
      {Key? key, required this.onTap, required this.title, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: this.onTap,
      title: Text(this.title, style: context.textTheme.headline5),
      trailing: Icon(this.icon, color: context.primaryColor, size: 35),
    );
  }
}
