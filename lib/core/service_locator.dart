import 'package:get_it/get_it.dart';

import '../api/api_const.dart';
import '../news_article/news_store.dart';

final sl = GetIt.instance;

class ServiceLocator {
  static Future<void> setup() async {
    sl.registerSingleton<NewsStore>(NewsStore(ApiConst.client));
  }
}
