import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {

final List<Expense> _registeredExpenses = [
  Expense(
    title: 'flutter course',
    amount: 500.00,
    date: DateTime.now(),
    category: Category.learnings,
  ),

  Expense(
    title: 'Cinema',
    amount: 354.99,
    date: DateTime.now(),
    category: Category.leisure,
  ),
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column( // to place chart above the list
        children: [
          Text('The chart'),
          Expanded(
              child: ExpensesList(expenses: _registeredExpenses)),
        ],
      ),
    );
  }
}
