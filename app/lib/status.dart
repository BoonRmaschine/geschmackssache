import 'package:flutter/material.dart';

class StatusPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text('Danke für deine Teilnahme!\nBis morgen ;)',
              style: TextStyle(fontSize: 22.0, color: Colors.white), textAlign: TextAlign.center,),)
        ],
      ),
    );
  }
}