import 'package:expenseapp/pages/expense_list.dart';
import 'package:expenseapp/pages/main_page.dart';
import 'package:flutter/material.dart';

// Single Responsibility
void main() {
  runApp(
    MaterialApp(theme: ThemeData(useMaterial3: true), home: const MainPage()),
  );
}

// modelleme => üzerinde çalışılacak yapıların uygulamada nesne haline getirilmesi