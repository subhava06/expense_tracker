import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();
const uuid = Uuid(); // to generate unique identifiers for each expense

enum Category { food, travel, leisure, work, learnings } // custom type category with fixed values

const categoryIcons = {
  Category.food : Icons.lunch_dining,
  Category.travel : Icons.flight_takeoff,
  Category.leisure : Icons.movie,
  Category.work : Icons.work,
  Category.learnings : Icons.school,
};
class Expense {

  Expense(
  {
    required this.title,
    required this.amount,
    required  this.date,
    required this.category,
   }) : id = uuid.v4(); // generates a unique string id


  final String id; // unique identifier for each expense
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

 String get formattedDate{
    return formatter.format(date);
  }
}

//to build a chart we need multiple buckets for each category
class ExpenseBucket {
  const ExpenseBucket (
  {
    required this.category,
    required this.expenses,
});

  ExpenseBucket.forCategory(
      List<Expense> allExpenses, this.category)
      : expenses = allExpenses.where((expense)=>expense.category == category).toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    // sums up all the expenses in the bucket
    double sum = 0;

     for(final expense in expenses)
       {
         sum += expense.amount;
       }

    return sum;
  }
}