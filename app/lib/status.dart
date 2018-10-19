import 'package:flutter/material.dart';

class StatusPage extends StatefulWidget{
  @override
  StatusPageState createState() => StatusPageState();
}

class StatusPageState extends State<StatusPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Danke für deine Teilnahme!', style: TextStyle(fontSize: 22.0),)
        ],
      ),
    );
  }
}