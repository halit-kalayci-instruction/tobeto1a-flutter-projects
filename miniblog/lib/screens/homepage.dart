import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniblog/blocs/article_bloc/article_bloc.dart';
import 'package:miniblog/blocs/article_bloc/article_event.dart';
import 'package:miniblog/blocs/article_bloc/article_state.dart';
import 'package:miniblog/screens/add_blog.dart';
import 'package:miniblog/widgets/blog_item.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    context.read<ArticleBloc>().add(ResetEvent());
  }

  void fetchAgain() {
    context.read<ArticleBloc>().add(FetchArticles());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bloglar"),
        actions: [
          IconButton(
              onPressed: () async {
                bool? result = await Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => AddBlog()));

                if (result == true) {
                  context.read<ArticleBloc>().add(FetchArticles());
                }
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: BlocBuilder<ArticleBloc, ArticleState>(builder: (context, state) {
        if (state is ArticlesInitial) {
          // bloc'a fetcharticles eventi göndermek
          context
              .read<ArticleBloc>()
              .add(FetchArticles()); // UI'dan BLOC'a Event
          return const Center(child: Text("İstek atılıyor..."));
        }

        if (state is ArticlesLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ArticlesLoaded) {
          return ListView.builder(
              itemCount: state.blogs.length,
              itemBuilder: (context, index) => BlogItem(
                    blog: state.blogs[index],
                    onBack: () => fetchAgain(),
                  ));
        }

        if (state is ArticlesError) {
          return const Center(
            child: Text("Bloglar yüklenirken bir hata oluştu."),
          );
        }

        return const Center(
          child: Text("Unknown State"),
        );
      }),
    );
  }
}
