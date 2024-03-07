import 'package:flutter/material.dart';
import 'package:xpense/models/expense_model.dart';
import 'package:xpense/widgets/expenses_list/expense_item.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key, required this.expenses, required this.onRemoveExpense});

  final void Function(Expense expense) onRemoveExpense;

  final List<Expense> expenses;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemCount: expenses.length ,itemBuilder: 
    (ctx,index)=> Dismissible(
      key : ValueKey(expenses[index]),
      onDismissed: (direction){onRemoveExpense(expenses[index]);},
    child: ExpenseItem(expenses[index])));
  }
}