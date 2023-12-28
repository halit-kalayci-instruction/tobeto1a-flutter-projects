import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniblog/blocs/article_bloc/article_bloc.dart';
import 'package:miniblog/blocs/article_bloc/article_event.dart';
import 'package:miniblog/blocs/article_bloc/article_state.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.id});
  final String id;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detay")),
      body: BlocBuilder<ArticleBloc, ArticleState>(builder: (context, state) {
        if (state is ArticlesInitial) {
          context.read<ArticleBloc>().add(FetchArticleDetail(id: widget.id));
          return Text("İstek atılmalı..");
        }

        if (state is ArticlesDetailLoaded) {
          return Center(
              child: Column(
            children: [
              Text("Detaylar yüklendi"),
              Text(state.blog.title!),
              Text(state.blog.content!)
            ],
          ));
        }

        return Center(
          child: Text(widget.id),
        );
      }),
    );
  }
}
