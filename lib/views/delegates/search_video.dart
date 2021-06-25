import 'package:flutter/material.dart';
import 'package:travel/core/router_manager.dart';
import 'package:travel/services/video_service.dart';
import 'package:travel/utils/utils.dart';

class SearchVideoDelegate extends SearchDelegate {
  SearchVideoDelegate()
      : super(
          searchFieldLabel: 'Gezilesiyer:',
          textInputAction: TextInputAction.search,
        );

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.remove, color: Theme.of(context).primaryColor))
    ];
  }


  @override
  Widget buildLeading(BuildContext context) {
    return Icon(Icons.video_call, color: Theme.of(context).primaryColor);
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView(
      children: [],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> provinces = Utils.turkeyProvinces();
    return ListView.builder(
      itemCount: provinces.length,
      itemBuilder: (_, index) => ListTile(
          onTap: () {
            VideoService.instance
                .listVideos(query: 'gezilesiyer ${provinces[index]}');
            RouteManager.backPage();
            // showResults(context);
          },
          title: Text(provinces[index])),
    );
  }
}
