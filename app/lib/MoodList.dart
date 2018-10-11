import 'SurveyStructs.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  Future<bool> postSurvey(Survey survey) async {
    final String url =
        'https://us-central1-geschmackssache-9a89b.cloudfunctions.net/addSurvey?';
    final String body = json.encode(survey);
    final response = await http.post(url, body: body);

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      return null;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  void _send() {
    widget.surveyState.mood = Mood(true, this._selectedMood);
    postSurvey(widget.surveyState);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(""),
        ),
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
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 45.0),
                child: RaisedButton(
                  textTheme: ButtonTextTheme.accent,
                  color: Theme.of(context).primaryColor,
                  onPressed: this._send,
                  child: Text(
                    "Senden",
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
