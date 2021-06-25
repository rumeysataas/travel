import 'package:flutter/material.dart';
import '../extensions/context_extensions.dart';
import '../extensions/string_extensions.dart';

class AppAvatar extends StatelessWidget {
  const AppAvatar({Key? key}) : super(key: key);

  //Tipik olarak bir kullanıcının profil resmiyle veya böyle bir resmin olmaması durumunda kullanıcının baş harfleriyle birlikte kullanılır.
  @override
  Widget build(BuildContext context) {
    return context.currentUser?.profilePhoto == 'na'
        ? CircleAvatar(
            backgroundColor: Colors.white,
            radius: 30,
            child: Text('${context.currentUser?.name?.avatarValue}',
                style: context.textTheme.headline5))
        : CircleAvatar(
            backgroundColor: Colors.white,
            radius: 30,
            backgroundImage:
                NetworkImage('${context.currentUser?.profilePhoto}'),
          );
  }
}
