
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(
      this.expense,
      {super.key});

  final Expense expense;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(expense.title, style:
            Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 4,),
            Row(
              children: [
               Text('\₹ ${expense.amount.toStringAsFixed(2)}'), // 12.3433 => 12.34 and curly braces tell dart that consider this as a single value
                Spacer(), // used in coln or row, tell dart to take as much space as possible between the widgets
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]), // now icons are generated dynamically based on the category
                    SizedBox(width: 8,),
                    Text(expense.formattedDate), // don`t add () becoz it is getter not a method here
                  ],
                ),

              ],
            ),

          ],
        ),
      ),
    );
  }
}
