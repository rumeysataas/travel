import 'package:flutter/material.dart';
import 'package:travel/custom_theme.dart';
import '../extensions/context_extensions.dart';

class AppMapPlace extends StatelessWidget {
  const AppMapPlace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(appDefaultPadding),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: Color(0xffdedede), borderRadius: BorderRadius.circular(20)),
      width: context.phoneHeight * .3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 70,
              width: 70,
              child: Placeholder(),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'İsim',
                  style: context.textTheme.headline5,
                ),
                Text(
                  'Kategori',
                  style: context.textTheme.headline6,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
