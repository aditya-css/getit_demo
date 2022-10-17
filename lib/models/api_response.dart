import 'article_model.dart';

class ApiResponse {
  final String status;
  final String? code, message;
  final int? totalResults;
  final List<ArticleApiModel>? articles;

  const ApiResponse({
    required this.status,
    this.code,
    this.message,
    this.totalResults,
    this.articles,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
        status: json['status'] as String,
        code: json['code'] as String?,
        message: json['message'] as String?,
        totalResults: json['totalResults'] as int?,
        articles: (json['articles'] as List<dynamic>?)
            ?.map(
              (e) => ArticleApiModel.fromJson(
                e as Map<String, dynamic>,
              ),
            )
            .toList(),
      );
}
