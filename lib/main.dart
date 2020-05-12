import 'dart:io';
import 'package:expense/models/transaction.dart';
import 'package:expense/widgets/chart.dart';
import 'package:expense/widgets/empty_list.dart';
import 'package:expense/widgets/new_transaction.dart';
import 'package:expense/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expense',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
          title: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          button: TextStyle(
            color: Colors.white
          )
        )
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(id: 't1', title: 'New shoes', amount: 99, date: DateTime.now()),
    // Transaction(id: 't2', title: 'New clothes', amount: 129, date: DateTime.now()),
  ];

  void _addNewTransaction(String title, double amount, DateTime date) {
    final newTx = Transaction(id: 't${_userTransactions.length}', title: title, amount: amount, date: date);
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(int index) {
    setState(() {
      _userTransactions.removeAt(index);
    });
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      final last30days = DateTime.now().subtract(Duration(days: 30));
      return last30days.isBefore(tx.date);
    }).toList();
  }

  startAddNewTransaction(BuildContext ctx) {
    return showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  Widget _iosNavigationBar() {
    return CupertinoNavigationBar(
      middle: Text('Finances'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            child: Icon(CupertinoIcons.add),
            onTap: () {
              startAddNewTransaction(context);
            },
          )
        ],
      ),
    );
  }

  Widget _androidNavigationBar() {
    return AppBar(
      title: Text('Finances'),
      actions: <Widget>[
        IconButton(icon: Icon(Icons.add), color: Colors.white, onPressed: () {
          startAddNewTransaction(context);
        },)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final PreferredSizeWidget appBar = Platform.isIOS ? _iosNavigationBar() : _androidNavigationBar();
    final body =  SafeArea(child:
      SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                height: (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.3,
                child: Chart(_recentTransactions)
            ),
            Container(
              height: (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.7,
              child: (_userTransactions.length > 0 ?
              (TransactionList(_userTransactions, _deleteTransaction)) :
              EmptyList()),
            ),
          ],
        ),
      ),
    );
    return Platform.isIOS ? CupertinoPageScaffold(
      navigationBar: appBar,
      child: body,
    ) : Scaffold(
      appBar: appBar,
      body: body,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS ? Container() : FloatingActionButton(child: Icon(Icons.add), onPressed: () => startAddNewTransaction(context),)
    );
  }
}