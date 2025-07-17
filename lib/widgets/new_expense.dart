import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {

  const NewExpense({super.key});
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


@override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _titleController, // to save user input
            maxLength : 50,
            //keyboardType:
            decoration: InputDecoration(
              label: Text('Title'),
            ),
          ),
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
                     Text('Selected Date'),
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

          Row(
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),

              ElevatedButton(
                  onPressed: () {
                        print(_titleController.text);
                        print(_amountController.text);
                  },
                  child: Text('Save Expense')),
            ],
          ),
        ],
      ),
    );
  }
}