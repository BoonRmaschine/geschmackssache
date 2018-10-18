import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  @override
  Widget build(context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Column(
        children: <Widget>[
          Text('UUID: ' + Uuid().v1()),
          Row(
            children: <Widget>[
              Text('Geschlecht'),
            ],
          ),
          Row(
            children: <Widget>[
              Text('Alter'),
              TextField(
                
              ),
            ],
          )
        ],
      ),
    );
  }
}