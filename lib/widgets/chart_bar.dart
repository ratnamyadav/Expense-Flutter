import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double amount;
  final double total;
  final double height;

  ChartBar(this.label, this.amount, this.total, this.height);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: height * 0.15,
          child: FittedBox(
            child: Text('₹${amount.toStringAsFixed(0)}'),
          ),
        ),
        SizedBox(
          height: height * 0.05,
        ),
        Container(
          height: height * 0.6,
          width: 10,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green, width: 1.0),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
              FractionallySizedBox(
                heightFactor: amount/total,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10)
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: height * 0.05,
        ),
        Container(
          height: height * 0.15,
          child: FittedBox(
            child: Text(label),
          )
        ),
      ],
    );
  }

}