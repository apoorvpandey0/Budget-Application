import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  // Constructor of the NewTransaction  class need to stay here in this class
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  // these help in inputting the data from the TextField
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime selectedDate;

  void submitData() {
    var enteredTitle = titleController.text;
    var enteredAmount = double.parse(amountController.text);

    // Super basic validation stuff
    if (enteredAmount <= 0 || enteredTitle.isEmpty || selectedDate == null) {
      return;
    }

    // "widget" allows us to access the methods and properties of the ststeful class
    // as you can see addTx is defined in stateful class
    widget.addTx(enteredTitle, enteredAmount, selectedDate);

    // This automatically closes the Modal once you press Done
    // The context parameter gives you access of the context in widget
    Navigator.of(context).pop();
  }

  void _dateSelector() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Column(

            // To push the button at the end/right of the line
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              // Text(
              //   'Add new transaction :)',
              //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              // ),
              // Title field
              TextField(
                decoration:
                    InputDecoration(labelText: 'What did you spend it on?'),
                controller: titleController,
                onSubmitted: (_) => submitData(),
              ),

              // Amount Field
              TextField(
                decoration:
                    InputDecoration(labelText: 'Enter the amount spent'),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData(),
              ),

              // This is the Date picker widget part
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Text(selectedDate == null
                        ? "No date choosen"
                        : DateFormat.yMMMd().format(selectedDate)),
                    FlatButton(
                        onPressed: _dateSelector, child: Text("Choose date"))
                  ],
                ),
              ),

              // Submit button, this is an alternative to Done button on keyboard
              FlatButton(
                  onPressed: () => submitData(),
                  child: Text(
                    'Add Transaction',
                    style: TextStyle(color: Colors.blue),
                  ))
            ]),
      ),
    );
  }
}
