import 'package:flutter/material.dart';
import 'package:mealsapp/models/meal.dart';

class MealList extends StatelessWidget {
  const MealList({Key? key, required this.meals}) : super(key: key);
  final List<Meal> meals;

  @override
  Widget build(BuildContext context) {
    Widget widget = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, index) => Text(meals[index].name));

    if (meals.isEmpty) {
      widget = const Center(
        child: Text("Bu kategoride hiç bir içerik bulunmamaktadır."),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("Yemek Listesi"),
        ),
        body: widget);
  }
}
