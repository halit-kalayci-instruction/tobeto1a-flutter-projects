abstract class ArticleEvent {}

class FetchArticles extends ArticleEvent {}

class FetchArticleDetail extends ArticleEvent {
  String id;

  FetchArticleDetail({required this.id});
}

class ResetEvent extends ArticleEvent {}
