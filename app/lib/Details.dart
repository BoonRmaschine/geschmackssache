import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  @override
  DetailsState createState() => DetailsState();
}

class DetailsState extends State<Details> {
  final _formKey = GlobalKey<FormState>();

  String uuid = "";
  String gender = "m";
  int age = -1;

  void saveDetails() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('uuid', this.uuid);
    prefs.setString('gender', this.gender);
    prefs.setInt('age', this.age);
    Navigator.pop(context);
  }

  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      setState(() {
        this.uuid = value.getString('uuid') ?? Uuid().v1();
      });
    });

    super.initState();
  }

  @override
  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Gib uns ein paar Details über dich'),
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.00),
              child: Column(
                children: <Widget>[
                  Text('Diese ID anonymisiert dich'),
                  Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Text(
                      this.uuid,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14.0),
                    ),
                  ),
                ],
              ),
            ),
            Form(
              key: this._formKey,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Text('Alter'),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: EdgeInsetsDirectional.only(
                              start: 20.0, end: 40.0),
                          child: TextFormField(
                            initialValue: '18',
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Bitte verrate uns dein Alter.';
                              }
                              int age = int.tryParse(value) ?? -1;
                              if (age <= 0) {
                                return 'Bitte gib eine Zahl ein.';
                              }
                              if (age < 18 || 100 < age) {
                                return 'Teilnahme zwischen 18 und 99 Jahren.';
                              }
                              setState(() {
                                this.age = age;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Text('Geschlecht'),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: RadioListTile(
                            title: Text('m'),
                            value: 'm',
                            groupValue: this.gender,
                            onChanged: (value) {
                              setState(() {
                                this.gender = value;
                              });
                            }),
                      ),
                      Expanded(
                        flex: 2,
                        child: RadioListTile(
                            title: Text('w'),
                            value: 'w',
                            groupValue: this.gender,
                            onChanged: (value) {
                              setState(() {
                                this.gender = value;
                              });
                            }),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        // Validate will return true if the form is valid, or false if
                        // the form is invalid.
                        if (_formKey.currentState.validate()) {
                          // If the form is valid, we want to show a Snackbar
                          this.saveDetails();
                        }
                      },
                      child: Text('Submit',
                          style: Theme.of(context).textTheme.button),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
