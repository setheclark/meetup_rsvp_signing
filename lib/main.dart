import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:meetup_event_signin/attendees/AttendeeList.dart';
import 'package:meetup_event_signin/attendees/model/Attendee.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  State createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<Attendee> attendees;

  Future<String> getData(BuildContext context) async {
    var _attendees = await DefaultAssetBundle
        .of(context)
        .loadString('assets/attendees.json');

    this.setState(() {
      var results = json.decode(_attendees)['results'];
      attendees = [];
      for (var r in results) {
        attendees.add(Attendee.fromJson(r));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.getData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendees"),
      ),
      body: attendees == null
          ? Text("Loading")
          : AttendeeList(attendees, (a) => print(a.name)),
    );
  }
}
