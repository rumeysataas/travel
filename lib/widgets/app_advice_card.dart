import 'package:flutter/material.dart';
import '../extensions/context_extensions.dart';

class AppAdviceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  const AppAdviceCard(
      {Key? key, required this.icon, required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: context.primaryColor, width: 2)),
      child: InkWell(
        onTap: this.onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              this.icon,
              color: context.primaryColor,
              size: 30,
            ),
            SizedBox(height: 5),
            Text(
              this.title,
              style: context.textTheme.subtitle1,
            )
          ],
        ),
      ),
    ));
  }
}
