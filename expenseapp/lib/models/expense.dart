// identifier => kimlik belirleyici (id)

import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Category { food, education, travel, work }

class Expense {
  Expense(
      {required this.name,
      required this.price,
      required this.date,
      required this.category})
      : id = uuid.v4();
  // ctor'da bir değeri almak yerine değer atamak

  final String id;
  final String name;
  final double price;
  final DateTime date;
  final Category category;
}
// e31d96a6-f15e-4787-ad2d-9d3965218523, Yemek, 50
// a975e32a-999b-47ac-ae73-929a66dd216c, Yemek, 50
// 28386049-6721-4bcb-adda-061a02020a42, Yemek, 50
// uuid , guid => 
// flutter'a paket ekleme

// Enums
// Enumerated Type