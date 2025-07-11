import 'package:uuid/uuid.dart';

const uuid = Uuid(); // to generate unique identifiers for each expense

enum Category { food, travel, leisure, work, learnings } // custom type category with fixed values
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
}