import 'package:flutter/material.dart';
import 'package:travel/models/PlaceModel.dart';
import '../extensions/context_extensions.dart';

class AppMapPlace extends StatelessWidget {
  final PlaceModel placeModel;
  final VoidCallback onTap;
  const AppMapPlace({Key? key, required this.placeModel, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
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
                height: 40,
                width: 40,
                child: Image.network(this.placeModel.icon),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      this.placeModel.name,
                      style: context.textTheme.headline5,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      this.placeModel.types[0],
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.headline6,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star_outline),
                      Text('${this.placeModel.rating.toString()}',
                          style: context.textTheme.headline6)
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
