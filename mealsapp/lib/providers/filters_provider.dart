import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterNotifier extends StateNotifier<List<String>> {
  FilterNotifier() : super([]); // initial state belirleme
}

// provider
final FilterProvider =
    StateNotifierProvider<FilterNotifier, List<String>>((ref) {
  return FilterNotifier();
});
