import 'SurveyStructs.dart';

import 'package:flutter/material.dart';

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

  void _send() {

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
                  onPressed: this._send,
                  child: Text("Senden"),
                ),
              ),
            ),
          ],
        ));
  }
}
