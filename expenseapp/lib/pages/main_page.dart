import 'package:expenseapp/pages/expense_list.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text("Expense App"),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context, builder: (ctx) => Text("Modal Deneme"));
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      body: ExpenseList(),
    );
  }
}
