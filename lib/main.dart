import 'package:expense/transaction.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(id: 't1', title: 'New shoes', amount: 99, date: DateTime.now()),
    Transaction(id: 't2', title: 'New clothes', amount: 129, date: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Card(
            child: Container(
              child: Text('Chart'),
              width: double.maxFinite,
              padding: EdgeInsets.all(10.0),
            ),
            elevation: 5,
          ),
          Column(
            children: transactions.map((t) {
              return Card(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Text(
                          'INR ${t.amount}',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple
                          ),
                        ),
                        padding: EdgeInsets.all(10.0),
                        margin: EdgeInsets.only(right: 10.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.purple, width: 1.0)
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Text(t.title),
                          Text(t.date.toString())
                        ],
                      )
                    ],),
                  width: double.maxFinite,
                  padding: EdgeInsets.all(10.0),
                ),
                elevation: 5,
              );
            }).toList(),
          )
        ],
      )
    );
  }

}