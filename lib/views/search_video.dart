import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel/core/router_manager.dart';
import 'package:travel/core/stateful_wrapper.dart';
import 'package:travel/custom_theme.dart';
import 'package:travel/models/VideoModel.dart';
import 'package:travel/services/video_service.dart';
import 'package:travel/views/watch_video.dart';
import '../extensions/context_extensions.dart';

class SearchVideo extends StatefulWidget {
  const SearchVideo({Key? key}) : super(key: key);

  @override
  _SearchVideoState createState() => _SearchVideoState();
}

class _SearchVideoState extends State<SearchVideo> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return StatefulWrapper(
      onInit: () {
        VideoService.instance.listVideos();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Gezilesi Yerler'),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(appDefaultPadding),
          child: AnimatedBuilder(
            animation: VideoService.instance,
            builder: (_, __) {
              return ListView.builder(
                itemCount: VideoService.instance.videos.length,
                itemBuilder: (_, index) {
                  VideoModel video = VideoService.instance.videos[index];
                  return Tooltip(
                    message: 'İzle',
                    child: ListTile(
                      onTap: () {
                        RouteManager.newPage(WatchVideo());
                      },
                      leading: Container(
                          width: 70,
                          height: 200,
                          child: Image.network(video.thumbnail,
                              fit: BoxFit.cover)),
                      title: Text(video.title.replaceAll('&#39;', "'")),
                      subtitle: Text(video.description),
                      trailing: Icon(
                        FontAwesomeIcons.youtube,
                        color: context.primaryColor,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
