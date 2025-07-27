

import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/cupertino.dart';

class ExpensesList extends StatelessWidget {

  const ExpensesList(
      {
        required this.expenses,
        required this.onRemoveExpense,
        super.key,}); // make sure this class accepts the list of expenses as an argument

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder( // list items are created only when they are needed
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(expenses[index]), // allows to remove list by swiping right
        background: Container(color: Theme.of(context).colorScheme.error,
        margin: EdgeInsets.symmetric(horizontal: Theme.of(context).cardTheme.margin!.horizontal),
        ),
        onDismissed: (direction) {
          onRemoveExpense(expenses[index]);
        },
        child: ExpenseItem(expenses[index]),),
    );
  }
}
