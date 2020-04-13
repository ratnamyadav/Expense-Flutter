import 'package:expense/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactions;
  final Function _deleteTransaction;

  TransactionList(this._userTransactions, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: FittedBox(
                      child: Text('₹ ${_userTransactions[index].amount.toStringAsFixed(2)}')
                  ),
                ),
              ),
              title: Text(_userTransactions[index].title),
              subtitle: Text(DateFormat.yMMMd().format(_userTransactions[index].date)),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  _deleteTransaction(index);
                },
              ),
            )
          );
        },
        itemCount: _userTransactions.length,
      ),
    );
  }

}