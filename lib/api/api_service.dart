import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/api_response.dart';
import 'api_const.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiClientService {
  factory ApiClientService(Dio dio) = _ApiClientService;

  @GET(ApiConst.kIndiaHeadlines)
  Future<ApiResponse> getTopArticles();
}
