import 'package:expenseapp/pages/expense_list.dart';
import 'package:flutter/material.dart';

// Single Responsibility
void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: ExpenseList(),
      ),
    ),
  );
}

// modelleme => üzerinde çalışılacak yapıların uygulamada nesne haline getirilmesi