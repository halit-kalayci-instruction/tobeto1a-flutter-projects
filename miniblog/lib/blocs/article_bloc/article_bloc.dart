import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniblog/blocs/article_bloc/article_event.dart';
import 'package:miniblog/blocs/article_bloc/article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  ArticleBloc() : super(ArticlesInitial()) {
    on<FetchArticles>(_onFetchArticles);
  }

  void _onFetchArticles(FetchArticles event, Emitter<ArticleState> emit) {
    emit(ArticlesLoading());

    // ....

    // .. ArticlesLoaded,ArticlesError
  }
}
