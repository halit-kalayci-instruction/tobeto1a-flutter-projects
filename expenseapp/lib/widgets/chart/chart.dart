import 'package:expenseapp/models/category_expense.dart';
import 'package:expenseapp/models/expense.dart';
import 'package:expenseapp/widgets/chart/chart_bar.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({Key? key, required this.expenses}) : super(key: key);
  final List<Expense> expenses;

  List<CategoryExpense> get categoryExpenses {
    return [
      CategoryExpense.forCategory(
          expenses, Category.education), // eğitim kategorisi harcamaları
      CategoryExpense.forCategory(expenses, Category.food), // food "" ""
      CategoryExpense.forCategory(expenses, Category.travel), //
      CategoryExpense.forCategory(expenses, Category.work),
    ];
  }

  double get maxTotal {
    double maxTotalExpense = 0;

    categoryExpenses.forEach((element) {
      if (element.totalExpensePrice > maxTotalExpense)
        maxTotalExpense = element.totalExpensePrice;
    });

    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0)
          ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
        ),
        child: Column(children: [
          Expanded(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: categoryExpenses
                .map((categoryExpense) => ChartBar(
                    height: categoryExpense.totalExpensePrice == 0
                        ? 0.01
                        : categoryExpense.totalExpensePrice / maxTotal))
                .toList(),
          )), //grafikleri render edecek
          const SizedBox(height: 10),
          Row(
            children: categoryExpenses
                .map((categoryExpense) => Expanded(
                    child: Icon(categoryIcons[categoryExpense.category])))
                .toList(),
          ) // ikonları render
        ]));
  }
}
