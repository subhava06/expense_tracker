


import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/cupertino.dart';

class ExpensesList extends StatelessWidget {

  const ExpensesList(
      {
        required this.expenses,
        super.key,}); // make sure this class accepts the list of expenses as an argument

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder( // list items are created only when they are needed
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Text(expenses[index].title),
    );
  }
}
