import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:miniblog/models/blog.dart';
import 'package:http/http.dart' as http;

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Blog> blogs = [];

  @override
  void initState() {
    super.initState();
    fetchBlogs();
  }

  fetchBlogs() async {
    Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");
    final response = await http.get(url);
    final List jsonData = json.decode(response.body);

    setState(() {
      blogs = jsonData.map((json) => Blog.fromJson(json)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Bloglar"),
          actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
        ),
        body: blogs.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemBuilder: (context, index) => Text(blogs[index].author!),
                itemCount: blogs.length));
  }
}
