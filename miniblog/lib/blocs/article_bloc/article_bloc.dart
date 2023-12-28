import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniblog/blocs/article_bloc/article_event.dart';
import 'package:miniblog/blocs/article_bloc/article_state.dart';
import 'package:miniblog/repositories/article_repository.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticleRepository articleRepository;

  ArticleBloc({required this.articleRepository}) : super(ArticlesInitial()) {
    on<FetchArticles>(_onFetchArticles);

    on<FetchArticleDetail>(_onFetchDetail);

    on<ResetEvent>(_resetEvent);
  }

  void _onFetchArticles(FetchArticles event, Emitter<ArticleState> emit) async {
    emit(ArticlesLoading());
    try {
      final articles = await articleRepository.fetchAllBlogs();
      emit(ArticlesLoaded(blogs: articles));
    } catch (e) {
      emit(ArticlesError());
    }
    // merhaba
  }

  void _onFetchDetail(
      FetchArticleDetail event, Emitter<ArticleState> emit) async {
    emit(ArticlesDetailLoading());
    try {
      final article = await articleRepository.fetchBlogById(event.id);
      emit(ArticlesDetailLoaded(blog: article));
    } catch (e) {
      emit(ArticlesDetailError());
    }
  }

  void _resetEvent(ResetEvent event, Emitter<ArticleState> emit) {
    emit(ArticlesInitial());
  }
}
