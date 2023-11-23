import 'package:expenseapp/models/expense.dart';
import 'package:expenseapp/widgets/chart/chart.dart';
import 'package:expenseapp/widgets/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatefulWidget {
  const ExpenseList(this.expenses, this.onRemove, {Key? key}) : super(key: key);
  final List<Expense> expenses;
  final void Function(Expense expense) onRemove;

  @override
  _ExpenseListState createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 250,
            child: Chart(
              expenses: widget.expenses,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.expenses.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: ValueKey(widget.expenses[index]),
                  child: ExpenseItem(widget.expenses[index]),
                  onDismissed: (direction) {
                    if (direction == DismissDirection.startToEnd) {
                      // soldan sağa ise
                    }
                    widget.onRemove(widget.expenses[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
// Topbar eklemek vs..
// Theming
// 10:15