import 'package:mobx/mobx.dart';

import '../api/api_service.dart';
import '../models/api_response.dart';
import '../models/article_model.dart';

part 'news_store.g.dart';

class NewsStore = _NewsStore with _$NewsStore;

abstract class _NewsStore with Store {
  _NewsStore(this._apiClient);

  final ApiClientService _apiClient;

  @computed
  bool get shouldShowFavIcon => favArticles.isNotEmpty;

  ObservableList<ArticleApiModel> favArticles = ObservableList.of([]);

  @action
  ObservableFuture<ApiResponse> getArticles() =>
      ObservableFuture<ApiResponse>(_apiClient.getTopArticles());
}
