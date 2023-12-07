// dynamic state

// iki adet yapı

// notifier
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsapp/models/meal.dart';

// 11:20

// initial state
class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]); // initial state belirleme

  void toggleMealFavorite(Meal meal) {
    List<Meal> newState;
    if (state.contains(meal)) {
      newState = state.where((element) => element.id != meal.id).toList();
    } else {
      newState = [...state, meal]; // spread operator
    }
    state = newState;

    // if (state.contains(meal)) {
    //   state.remove(meal);
    // } else {
    //   state.add(meal);
    // }
  }
}

// provider
final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  return FavoriteMealsNotifier();
});

// boilerplate