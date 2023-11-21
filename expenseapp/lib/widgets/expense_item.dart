import 'package:expenseapp/models/expense.dart';
import 'package:flutter/material.dart';

// 10:05
class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {Key? key}) : super(key: key);
  final Expense expense;
  // Dismissible
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            Text(
              expense.name,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Row(
              children: [
                // String Interpolation
                Text("${expense.price.toStringAsFixed(2)} ₺"), // Alt GR + T
                const Spacer(),
                Icon(categoryIcons[expense.category]),
                const SizedBox(width: 8),
                Text(expense.formattedDate)
              ],
            )
          ],
        ),
      ),
    );
  }
}
