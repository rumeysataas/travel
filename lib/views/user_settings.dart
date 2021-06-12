import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel/core/router_manager.dart';
import 'package:travel/core/storage.dart';
import 'package:travel/views/login_view.dart';
import '../extensions/context_extensions.dart';

class UserSettings extends StatefulWidget {
  UserSettings({Key? key}) : super(key: key);

  @override
  _UserSettingsState createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  @override
  Widget build(BuildContext context) {
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
            ListTile(
              onTap: () {},
              title: Text('Şehir Değiştir', style: context.textTheme.headline5),
              trailing: Icon(Icons.map, color: context.primaryColor, size: 35),
            ),
            ListTile(
              onTap: () {
                FirebaseAuth.instance.signOut();
                RouteManager.newPageReplacement(LoginView());
              },
              title: Text('Çıkış Yap', style: context.textTheme.headline5),
              trailing:
                  Icon(Icons.logout, color: context.primaryColor, size: 35),
            ),
          ],
        ),
      ),
    );
  }
}
