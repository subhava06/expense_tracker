import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {

  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {

//   var _enteredTitle = '';
// void _saveTitleInput(String inputValue) {
//   _enteredTitle = inputValue;
// } // Flutter gives TextEditingController to manage autonomously the text entered by the user

 final _titleController = TextEditingController();
 final _amountController = TextEditingController();
 DateTime? _selectedDate ;
 Category _selectedCategory = Category.leisure;

// function to trigger picking a date
  void _presentDatePicker() async
  {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
   // final lastDate = DateTime(now.year +1, now.month, now.day);
    // use inbuilt method of flutter
   final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
   print(pickedDate);
   setState(() {
     _selectedDate = pickedDate;
   });
  }

  //validating user input
  void _submitExpenseData () {
   final enteredAmount = double.tryParse( _amountController.text); // tryParse('hello') => null, tryParse('1.12') => 1.12
   final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

   if(_titleController.text.trim().isEmpty || amountIsInvalid || _selectedDate == null) {
     // show error message
     showDialog(context: context,
         builder: (ctx) => AlertDialog( // Error dialog box
           title: Text('Invalid Input'),
           content: Text('Please make sure a valid title, amount,date and category is entered.'),
           actions: [
             TextButton(
                 onPressed: () {Navigator.pop(ctx); },
                 child: Text('Okay'),
             ),
           ],
         )
     );
     return;
   }
   widget.onAddExpense(
     Expense(
       title: _titleController.text,
       amount: enteredAmount,
       date: _selectedDate!,
       category: _selectedCategory,
     ),
   );
   Navigator.pop(context); // to close the overlay after adding expense
}

@override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  final keyboardSpace =  MediaQuery.of(context).viewInsets.bottom;
     return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;

       return SizedBox(
         height: double.infinity,
         child: SingleChildScrollView(
           child: Padding(
             padding: EdgeInsets.fromLTRB(16,48,16, keyboardSpace+ 16),
             child: Column(
               children: [
                 if(width >=600)
                   Row(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                     Expanded(
                       child: TextField(
                         controller: _titleController, // to save user input
                         maxLength : 50,
                         //keyboardType:
                         decoration: InputDecoration(
                           label: Text('Title'),
                         ),
                       ),
                     ),
                     SizedBox(width: 24,),
                     Expanded( // Textfield and row by default contradict eachother so it is necessary to wrap in Expanded to ensure it takes as much space but not more
                       child: TextField(
                         controller: _amountController, // to save user input
                         //maxLength : 50,
                         keyboardType: TextInputType.number ,
                         decoration: InputDecoration(
                           prefixText: '\₹ ',
                           label: Text('Amount'),
                         ),),
                     ),
                   ],)
                 else
                 TextField(
                   controller: _titleController, // to save user input
                   maxLength : 50,
                   //keyboardType:
                   decoration: InputDecoration(
                     label: Text('Title'),
                   ),
                 ),
                 if(width >=600)
                   Row(children: [
                     DropdownButton(
                         value: _selectedCategory,
                         items: Category.values.map(
                               (category) => DropdownMenuItem(
                             value: category,
                             child: Text(
                               category.name.toUpperCase(),
                             ),
                           ),
                         ).toList(),
                         onChanged: (value){
                           if(value == null) {
                             return;
                           }
                           setState(() {
                             _selectedCategory = value;
                           });
                         }
                     ),
                     SizedBox(width: 24,),
                     Expanded( // wrapped since a row inside another row
                       child: Row( // to gather date input together
                         mainAxisAlignment: MainAxisAlignment.end,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           Text(
                               _selectedDate == null?
                               'No date selected'
                                   : formatter.format(_selectedDate!)),
                           IconButton(
                             onPressed: _presentDatePicker,
                             icon: Icon(
                               Icons.calendar_month,),
                           ),
                         ],
                       ),
                     ),

                   ],)
                 else
                 Row(
                   children: [
                     Expanded( // Textfield and row by default contradict eachother so it is necessary to wrap in Expanded to ensure it takes as much space but not more
                       child: TextField(
                         controller: _amountController, // to save user input
                         //maxLength : 50,
                         keyboardType: TextInputType.number ,
                         decoration: InputDecoration(
                           prefixText: '\₹ ',
                           label: Text('Amount'),
                         ),),
                     ),
                     const SizedBox(width: 16), // for spacing b/wn amount textfield and date picker
                     Expanded( // wrapped since a row inside another row
                       child: Row( // to gather date input together
                         mainAxisAlignment: MainAxisAlignment.end,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           Text(
                               _selectedDate == null?
                               'No date selected'
                                   : formatter.format(_selectedDate!)),
                           IconButton(
                             onPressed: _presentDatePicker,
                             icon: Icon(
                               Icons.calendar_month,),
                           ),
                         ],
                       ),
                     ),
                   ],
                 ),
                 SizedBox(height: 16,),
                 if(width >=600)
                   Row(children: [
                     Spacer(),
                     TextButton(
                         onPressed: () {
                           Navigator.pop(context);
                         },
                         child: Text('Cancel')
                     ),
                     ElevatedButton(
                         onPressed: _submitExpenseData,
                         child: Text('Save Expense')),
                   ],)
                 else
                 Row(
                   children: [
                     DropdownButton(
                         value: _selectedCategory,
                         items: Category.values.map(
                               (category) => DropdownMenuItem(
                             value: category,
                             child: Text(
                               category.name.toUpperCase(),
                             ),
                           ),
                         ).toList(),
                         onChanged: (value){
                           if(value == null) {
                             return;
                           }
                           setState(() {
                             _selectedCategory = value;
                           });
                         }
                     ), // flutter now knows that value here is of type category
                     Spacer(),
                     TextButton(
                         onPressed: () {
                           Navigator.pop(context);
                         },
                         child: Text('Cancel')
                     ),
                     ElevatedButton(
                         onPressed: _submitExpenseData,
                         child: Text('Save Expense')),
                   ],
                 ),
               ],
             ),
           ),
         ),
       );
     });

  }
}