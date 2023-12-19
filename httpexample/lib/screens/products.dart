import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:httpexample/models/product.dart';

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  List<Product> productList = [];

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  void getProducts() async {
    Uri url = Uri.https("dummyjson.com", "products");
    // http istekleri ASYNC'dır
    // await keywordü
    final response = await http.get(url);
    final data = json.decode(response.body);
    final products = data["products"];
    List<Product> productsFromWebAPI = [];

    for (final item in products) {
      Product product = Product(
          id: item["id"],
          title: item["title"],
          description: item["description"],
          price: item["price"]);
      productsFromWebAPI.add(product);
    }

    setState(() {
      productList = productsFromWebAPI;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
          itemCount: productList.length,
          itemBuilder: (ctx, index) => Text(productList[index].title)),
    );
  }
}
