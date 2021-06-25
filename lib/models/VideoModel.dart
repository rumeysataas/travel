
//video sonuçları için göstereceğimiz videoId, başlık, küçük resim, yayımlanma tarihi ve açıklamayı tutan modelimiz.
class VideoModel {
  final String videoId;
  final String title;
  final String thumbnail;
  final String publishTime;
  final String description;

  VideoModel(
      {required this.videoId,
      required this.title,
      required this.thumbnail,
      required this.publishTime,
      required this.description});

  factory VideoModel.fromJson(Map json) {
    return VideoModel(
      title: json['snippet']['title'],
      description: json['snippet']['description'],
      publishTime: json['snippet']['publishTime'],
      videoId: json['id']['videoId'],
      thumbnail: json['snippet']['thumbnails']['medium']['url'],
    );
  }
}
