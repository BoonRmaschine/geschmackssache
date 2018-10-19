import 'SurveyStructs.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class MoodSelection extends StatefulWidget {
  final Survey surveyState;

  const MoodSelection({this.surveyState}) : super();

  MoodSelectionState createState() => MoodSelectionState();
}

class MoodSelectionState extends State<MoodSelection> {
  List<Mood> _moods = moodList.map((mood) {
    return new Mood(false, mood);
  }).toList();

  String _selectedMood;
  double progress = 0.0;

  final _scaffoldKey = GlobalKey<ScaffoldState>();


  Future<bool> postSurvey(Survey survey) async {
    final String url =
        'https://us-central1-geschmackssache-9a89b.cloudfunctions.net/addSurvey?';
    final prefs = await SharedPreferences.getInstance();
    survey.uuid = prefs.getString('uuid');
    survey.gender = prefs.getString('gender');
    survey.age = prefs.getInt('age');
    final String body = json.encode(survey);
    final response = await http.post(url, body: body).catchError((error){
      final snackBar = SnackBar(content: Text('Fehler beim senden der Umfrage (Fehler: $error)'));
      Scaffold.of(context).showSnackBar(snackBar);
    });

    if (response.statusCode == 200) {
      setState(() {
        this.progress = 0.0;
      });
      return true;
    } else {
      final snackBar = SnackBar(content: Text('Fehler beim senden der Umfrage (Fehler: $response)'));
      Scaffold.of(context).showSnackBar(snackBar);
      return false;
    }
  }

  void _send() async {
    widget.surveyState.mood = Mood(true, this._selectedMood);
    postSurvey(widget.surveyState);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(""),
        ),
        body: Scaffold(
          key: _scaffoldKey,
          body: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Sag uns, wie du dich dabei gefühlt hast.",
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: ListView(
                    children: this._moods.map((mood) {
                      return new RadioListTile(
                          title: Text(mood.feeling),
                          value: mood.feeling,
                          groupValue: this._selectedMood,
                          onChanged: (String value) {
                            setState(() {
                              this._selectedMood = value;
                            });
                          });
                    }).toList(),
                  ),
                ),
              ),
              LinearProgressIndicator(
                backgroundColor: Colors.white12,
                value: this.progress,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 45.0),
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () async {
                      setState(() {
                        this.progress = null;
                      });
                      widget.surveyState.mood = Mood(true, this._selectedMood);
                      final String url =
                          'https://us-central1-geschmackssache-9a89b.cloudfunctions.net/addSurvey?';
                      final prefs = await SharedPreferences.getInstance();
                      widget.surveyState.uuid = prefs.getString('uuid');
                      widget.surveyState.gender = prefs.getString('gender');
                      widget.surveyState.age = prefs.getInt('age');
                      final String body = json.encode(widget.surveyState);
                      final response = await http.post(url, body: body).catchError((error){
                        print('No connection');
                        setState(() {
                          this.progress = 0.0;
                        });
                      });

                      if(response == null){
                        final snackBar = SnackBar(content: Text('Kein Internet verfügbar'));
                        _scaffoldKey.currentState.showSnackBar(snackBar);
                        return false;
                      }

                      if (response.statusCode == 200) {
                        setState(() {
                          this.progress = 0.0;
                        });
                        return true;
                      } else {
                        final snackBar = SnackBar(content: Text('Fehler beim senden der Umfrage (Fehler: $response)'));
                        _scaffoldKey.currentState.showSnackBar(snackBar);
                        return false;
                      }
                    },
                    child: Text(
                        "Senden", style: Theme.of(context).textTheme.button
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
        );
  }
}
