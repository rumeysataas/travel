import 'package:flutter/material.dart';
import 'package:travel/models/VideoModel.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../extensions/context_extensions.dart';
import '../extensions/datetime_extensions.dart';


class WatchVideo extends StatelessWidget {
  final VideoModel videoModel;
  const WatchVideo({Key? key, required this.videoModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: this.videoModel.videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
    DateTime date = DateTime.parse(this.videoModel.publishTime);
    print('year' + date.year.toString());
    return Scaffold(
      body: SafeArea(
        child: YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: _controller,
            ),
            builder: (context, player) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // some widgets
                  player,
                  SizedBox(height: 5),
                  ListTile(
                      title: Text(
                          this.videoModel.title.replaceAll('&#39;', "'"),
                          style: context.textTheme.headline5
                              ?.copyWith(fontWeight: FontWeight.bold)),
                      subtitle: Text(this.videoModel.description,
                          style: context.textTheme.headline6
                              ?.copyWith(fontWeight: FontWeight.normal))),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        text: TextSpan(
                            style: TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  text: '${date.getPublishTime}'),
                              TextSpan(text: ' Tarihinde Yayımlandı')
                            ]),
                      ))
                  //some other widgets
                ],
              );
            }),
      ),
    );
  }
}
