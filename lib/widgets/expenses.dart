import "package:flutter/material.dart";
import 'package:xpense/widgets/expenses_list/expenses_list.dart';
import 'package:xpense/models/expense_model.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses =
  [
    Expense(title: 'flutter', amount: 999, date: DateTime.now(), category: Category.work),
    Expense(title: 'movie', amount: 120, date: DateTime.now(), category: Category.leisure)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Xpense'),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          Text('The chart'),
          Expanded(child: ExpenseList(expenses: _registeredExpenses))
        ],
      ),
    );
  }
}