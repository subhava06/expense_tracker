import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
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

// this will open the add expense overlay
void _openAddExpenseOverlay() {
  //showModalBottomSheet is built in method of flutter
       showModalBottomSheet(
         isScrollControlled: true,
           context: context,
           builder: (ctx) => NewExpense(onAddExpense:_addExpense), // new expense widget
       );
}

 void _addExpense(Expense expense)
 {
  setState(() {
    _registeredExpenses.add(expense); // add an item to the list

  });
 }

 void _removeExpense(Expense expense) { // this ensures that the expense is also removed internally not just externally

   setState(() {
     _registeredExpenses.remove(expense);
   });
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: Text('Flutter Expense Tracker'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column( // to place chart above the list
        children: [
          Text('The chart'),
          Expanded(
              child: ExpensesList(expenses: _registeredExpenses, onRemoveExpense: _removeExpense,)),
        ],
      ),
    );
  }
}
