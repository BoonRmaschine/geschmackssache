import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

class StatusNoPage extends StatelessWidget {

  final timeout = const Duration(seconds: 3);
  final ms = const Duration(milliseconds: 1);

  Widget build(BuildContext context) {
    new Timer(new Duration(seconds: 3), () => exit(0));
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .primaryColor,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text('Schade :(\nBis morgen!',
              style: TextStyle(fontSize: 22.0, color: Colors.white),
              textAlign: TextAlign.center,),)
        ],
      ),
    );
  }
}