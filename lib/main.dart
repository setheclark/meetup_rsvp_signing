import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meetup_event_signin/attendees/AttendeeList.dart';
import 'package:meetup_event_signin/attendees/model/Attendee.dart';

const bool DEBUG = true;

void main() {
  runApp(MaterialApp(
    home: SplashScreen(),
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    if (DEBUG) {
      fetchRsvps(context);
    } else {
      fetchRsvpsFromFirestore(context);
    }
  }

  void navigateToRsvpList(BuildContext context, List<Attendee> rsvps) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => RsvpListPage(rsvps)),
    );
  }

  void fetchRsvpsFromFirestore(BuildContext context) async {
    List<Attendee> attendees = [];

    var docs = await Firestore.instance
        .collection("events")
        .document("io2018")
        .collection("rsvps")
        .where("attending", isEqualTo: false)
        .where("meetup_rsvp", isEqualTo: true)
        .getDocuments();

    docs.documents.forEach((doc) => attendees.add(Attendee.fromQuery(doc)));

    navigateToRsvpList(context, attendees);
  }

  void fetchRsvps(BuildContext context) async {
    var _attendees = await DefaultAssetBundle
        .of(context)
        .loadString('assets/attendees.json');

    var results = json.decode(_attendees)['results'];
    List<Attendee> attendees = [];
    for (var r in results) {
      attendees.add(Attendee.fromJson(r));
    }

    navigateToRsvpList(context, attendees);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/gdg_charlotte_logo.png'),
      ),
    );
  }
}

class RsvpListPage extends StatefulWidget {
  final List<Attendee> attendees;

  RsvpListPage(this.attendees);

  @override
  State<StatefulWidget> createState() => RsvpListState(attendees);
}

class RsvpListState extends State<RsvpListPage> {
  List<Attendee> _attendees;

  RsvpListState(this._attendees);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendees"),
      ),
      body: _attendees == null
          ? Text("Loading")
          : AttendeeList(_attendees, (a) => print(a.name)),
    );
  }
}
