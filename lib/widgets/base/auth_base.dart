import 'package:flutter/material.dart';
import '../../custom_theme.dart';


//Kimlik yetkilendirmesi
//kullanıcı daha önce oturum açmışsa otomatik olarak.
class AuthBase extends StatelessWidget {
  final List<Widget> children;
  const AuthBase({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 20,
              left: -30 / 2 - 30 / 2,
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(appDefaultPadding),
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: this.children),
              ),
            )
          ],
        ),
      ),
    );
  }
}
