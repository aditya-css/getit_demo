import 'package:dio/dio.dart';

import 'api_service.dart';

class ApiConst {
  //base
  static const String kApiKey = '5377d5133c384339aa839c6bcdfe9d6f';

  // static const String kApiKey = '06e4a1e179734ea28b66bcf21de6eea7';
  static const String kBaseUrl = 'https://newsapi.org/v2/';

  //endpoints
  static const String kIndiaHeadlines = '/top-headlines?country=in';

  //client
  static ApiClientService client = ApiClientService(
    Dio(
      BaseOptions(
        headers: const <String, String>{'X-Api-Key': kApiKey},
        baseUrl: kBaseUrl,
      ),
    ),
  );
}
