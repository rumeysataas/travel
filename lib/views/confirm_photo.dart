import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:travel/services/auth_service.dart';

class ConfirmPhoto extends StatelessWidget {
  final File image;
  ConfirmPhoto({Key? key, required this.image}) : super(key: key);
  final ValueNotifier<bool> loading = ValueNotifier(false);

  _changeProfilePhoto() async {
    loading.value = true;
    Random random = Random();
    final String filename = random.nextInt(50).toString() + '.png';
    await firebase_storage.FirebaseStorage.instance
        .ref('uploads/$filename')
        .putFile(this.image);
    String downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref('uploads/$filename')
        .getDownloadURL();
    await AuthService.instance.newProfilePhoto(downloadURL);
    loading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: ValueListenableBuilder<bool>(
              valueListenable: loading,
              builder: (_, val, __) {
                return val
                    ? CircularProgressIndicator()
                    : Container(
                        child: Image.file(this.image),
                      );
              }),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.green[800],
            onPressed: _changeProfilePhoto,
            child: Icon(Icons.done)));
  }
}
