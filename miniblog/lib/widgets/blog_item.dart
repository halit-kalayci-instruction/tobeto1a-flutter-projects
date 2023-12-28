import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniblog/blocs/article_bloc/article_bloc.dart';
import 'package:miniblog/blocs/article_bloc/article_event.dart';
import 'package:miniblog/blocs/article_bloc/article_state.dart';
import 'package:miniblog/models/blog.dart';
import 'package:miniblog/screens/details.dart';

class BlogItem extends StatelessWidget {
  const BlogItem({super.key, required this.blog, required this.onBack});
  final void Function() onBack;
  final Blog blog;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticleBloc, ArticleState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            if (state is! ArticlesInitial) {
              context.read<ArticleBloc>().add(ResetEvent());
            }
            Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => DetailPage(id: blog.id!)));
          },
          child: Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  AspectRatio(
                      aspectRatio: 4 / 2,
                      child: Container(
                          width: double.infinity,
                          color: Colors.grey[300],
                          child:
                              Center(child: Image.network(blog.thumbnail!)))),
                  ListTile(
                    title: Text(blog.title!),
                    subtitle: Text(blog.author!),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
