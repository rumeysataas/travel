import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travel/custom_theme.dart';
import '../extensions/context_extensions.dart';

class AppCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final VoidCallback onTap;
  AppCard(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.imageUrl,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(appDefaultPadding),
      decoration: BoxDecoration(
          color: Color(0xffdedede), borderRadius: BorderRadius.circular(30)),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: double.infinity,
      width: 250,
      child: InkWell(
        onTap: this.onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SvgPicture.asset(
                'assets/images/${this.imageUrl}',
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  this.title,
                  style: context.textTheme.headline5!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  this.subtitle,
                  style: context.textTheme.headline6,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
