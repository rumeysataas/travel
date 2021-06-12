import 'package:flutter/material.dart';
import '../extensions/context_extensions.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(context.currentUser?.name);
    return Scaffold(
      body: SafeArea(child: Text('${context.currentUser?.name}')),
    );
  }
}
