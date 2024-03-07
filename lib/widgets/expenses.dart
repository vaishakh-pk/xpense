import "package:flutter/material.dart";
import 'package:xpense/widgets/expenses_list/expenses_list.dart';
import 'package:xpense/models/expense_model.dart';
import 'package:xpense/widgets/new_expense.dart';

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

  void _openAddExpenseOverlay()
  {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context, builder: (ctx){
      return NewExpense(onAddExpense : _addExpense);
    });
  }

  void _addExpense(Expense expense)
  {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense)
  {
    setState(() {
      _registeredExpenses.remove(expense);
    });
  }

  @override
  Widget build(BuildContext context) {

    Widget mainContent = Center(child: Text('No Expenses found. Start adding some'));

    return Scaffold(
      appBar: AppBar(
        title: Text('Xpense'),
        actions: [
          IconButton(onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          Text('The chart'),
          Expanded(child: ExpenseList(expenses: _registeredExpenses, onRemoveExpense: _removeExpense,))
        ],
      ),
    );
  }
}