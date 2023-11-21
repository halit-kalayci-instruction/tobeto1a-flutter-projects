import 'package:expenseapp/pages/main_page.dart';
import 'package:flutter/material.dart';

ColorScheme lightColorsScheme = ColorScheme.fromSeed(seedColor: Colors.black54);
void main() {
  // Tema kuralları özelden globale doğru önem sırası arz eder.
  runApp(
    MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightColorsScheme,
          appBarTheme: const AppBarTheme().copyWith(
              backgroundColor: lightColorsScheme.onPrimaryContainer,
              foregroundColor: lightColorsScheme.primaryContainer),
          cardTheme: const CardTheme().copyWith(
              color: lightColorsScheme.onPrimaryContainer,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
          textTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: lightColorsScheme.primary,
                    fontSize: 16),
              ),
        ),
        home: MainPage()),
  );
}

// modelleme => üzerinde çalışılacak yapıların uygulamada nesne haline getirilmesi

// global theme modülleri hazırlamak
// silme işleminde Snackbar gösterilmesi ve undo işleminin kodlanması..