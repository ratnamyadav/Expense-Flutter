import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            height: 300, 
            margin: EdgeInsets.all(20),
            child: Image(
                image: AssetImage('assets/images/waiting.png')
            )
        )
    );
  }
  
}