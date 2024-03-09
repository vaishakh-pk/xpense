import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xpense/models/expense_model.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
//Controller to manage input
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

//Display the date picker using built-in showDatePicker function
  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context, firstDate: firstDate, lastDate: now);

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Invalid Input'),
                content: const Text(
                    'Please make sure a valid title, date and amount was entered'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: Text('Okay'))
                ],
              ));
      return;
    }

    widget.onAddExpense(Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory));
    Navigator.pop(context);
  }

/*Dispose TextEditingController after use else will remain in memory 
even when the widget is not displayed*/
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    //Layout builder is used as an alternative approach to MediaQuerry
    return LayoutBuilder(builder: (ctx, constraints) {
      final maxWidth = constraints.maxWidth;

      return Padding(
        padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardSpace + 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (maxWidth >= 600)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _titleController,
                        maxLength: 50,
                        decoration: const InputDecoration(label: Text('Title')),
                      ),
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _amountController,
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            prefixText: '\$', label: Text('Amount')),
                      ),
                    ),
                  ],
                )
              else
                TextField(
                  controller: _titleController,
                  maxLength: 50,
                  decoration: const InputDecoration(label: Text('Title')),
                ),
              const SizedBox(
                height: 10,
              ),
              if (maxWidth >= 600)
                Row(
                  children: [
                    DropdownButton(
                        value: _selectedCategory,
                        items: Category.values
                            .map((category) => DropdownMenuItem(
                                value: category,
                                child: Text(category.name.toUpperCase())))
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _selectedCategory = value;
                          });
                        }),
                    const SizedBox(
                      width: 24,
                    ),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(_selectedDate == null
                            ? 'Selected Date'
                            : formatter.format(_selectedDate!)),
                        IconButton(
                            onPressed: _presentDatePicker,
                            icon: const Icon(Icons.calendar_month_outlined))
                      ],
                    ))
                  ],
                )
              else
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _amountController,
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            prefixText: '\$', label: Text('Amount')),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(_selectedDate == null
                            ? 'Selected Date'
                            : formatter.format(_selectedDate!)),
                        IconButton(
                            onPressed: _presentDatePicker,
                            icon: const Icon(Icons.calendar_month_outlined))
                      ],
                    ))
                  ],
                ),
              const SizedBox(height: 16),
              if(maxWidth >= 600)
              Row(
                children: [
                  const Spacer(),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel')),
                  ElevatedButton(
                      onPressed: _submitExpenseData,
                      child: const Text('Save Expense'))
                ],
              )
              else
              Row(
                children: [
                  DropdownButton(
                      value: _selectedCategory,
                      items: Category.values
                          .map((category) => DropdownMenuItem(
                              value: category,
                              child: Text(category.name.toUpperCase())))
                          .toList(),
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        setState(() {
                          _selectedCategory = value;
                        });
                      }),
                  const Spacer(),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel')),
                  ElevatedButton(
                      onPressed: _submitExpenseData,
                      child: const Text('Save Expense'))
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
