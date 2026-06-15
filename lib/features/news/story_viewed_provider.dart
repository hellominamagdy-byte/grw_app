import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grw_app/features/news/news_data.dart';

class StoryViewedNotifier extends Notifier<Set<String>> {
  @override
  Set<String> build() => {};

  void markViewed(String articleId) {
    if (state.contains(articleId)) return;
    state = {...state, articleId};
  }

  bool isCategoryFullyViewed(String category) {
    final articles = NewsData.byCategory(category);
    if (articles.isEmpty) return false;
    return articles.every((article) => state.contains(article.id));
  }
}

final storyViewedProvider =
    NotifierProvider<StoryViewedNotifier, Set<String>>(StoryViewedNotifier.new);
