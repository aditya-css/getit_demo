import '../core/utils.dart';

class ArticleApiModel {
  final int? aid;
  final Map<String, dynamic>? src;
  final String? writer, body;
  final String? heading, desc;
  final String? link, imgUrl;
  final String date;

  ArticleApiModel({
    this.aid,
    required this.src,
    this.writer,
    this.body,
    this.heading,
    this.desc,
    this.link,
    this.imgUrl,
    required this.date,
  });

  factory ArticleApiModel.fromJson(Map<String, dynamic> json) =>
      ArticleApiModel(
        aid: json['id'] as int?,
        src: json['source'] as Map<String, dynamic>?,
        writer: json['author'] as String?,
        body: json['content'] as String?,
        heading: json['title'] as String?,
        desc: json['description'] as String?,
        link: json['url'] as String?,
        imgUrl: json['urlToImage'] as String?,
        date: TimeAgo(json['publishedAt']).calculate,
      );
}
