import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction) {
    print('Constructor New transaction');
  }

  @override
  _NewTransactionState createState() {
    print('Create State New transaction');
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  _NewTransactionState() {
    print('Constructor New transaction State');
  }

  @override
  void initState() {
    super.initState();
    print('initState New transaction State');
  }

  @override
  void didUpdateWidget(NewTransaction oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget New transaction State');
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose New transaction State');
  }

  _submitData() {
    final title = _titleController.text;
    final amount = double.parse(_amountController.text);
    if (title.isEmpty && amount <= 0) {

    } else {
      widget.addNewTransaction(
        title,
        amount,
        _selectedDate
      );
      Navigator.of(context).pop();
    }
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if(pickedDate == null) {
        return;
      }
      _selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                  labelText: 'Title'
              ),
              controller: _titleController,
            ),TextField(
              decoration: InputDecoration(
                  labelText: 'Amount'
              ),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(_selectedDate == null ? 'No date Selected' : DateFormat.yMMMd().format(_selectedDate)),
                Platform.isIOS ? CupertinoButton(
                  child: Text('Choose Date', style: TextStyle(fontWeight: FontWeight.bold),),
                  onPressed: _presentDatePicker,
                ) :
                FlatButton(
                  child: Text('Choose Date', style: TextStyle(fontWeight: FontWeight.bold),),
                  onPressed: _presentDatePicker,
                )
              ],
            ),
            Platform.isIOS ? CupertinoButton(
              color: Theme.of(context).primaryColor,
              child: Text(
                  'Add Transaction',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.button.color
                  )
              ),
              onPressed: _submitData,
            ) : FlatButton(
              color: Theme.of(context).primaryColor,
              child: Text(
                'Add Transaction',
                style: TextStyle(
                    color: Theme.of(context).textTheme.button.color
                )
              ),
              onPressed: _submitData,
            )
          ],
        ),
      ),
    );
  }
}