import 'package:flutter/material.dart';
import 'package:mealsapp/models/meal.dart';

class MealDetails extends StatefulWidget {
  const MealDetails({super.key, required this.meal});
  final Meal meal;

  @override
  State<MealDetails> createState() => _MealDetailsState();
}

class _MealDetailsState extends State<MealDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.meal.name),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border))
        ],
      ),
      body: Text(widget.meal.name),
    );
  }
}
