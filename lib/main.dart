import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:meetup_event_signin/attendees/AttendeeList.dart';
import 'package:meetup_event_signin/attendees/model/Attendee.dart';

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
    fetchRsvps(context);
  }

  void navigateToRevpList(BuildContext context, List<Attendee> rsvps) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => RsvpListPage(rsvps)),
    );
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

    navigateToRevpList(context, attendees);
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

//class HomePage extends StatefulWidget {
//  @override
//  State createState() => HomePageState();
//}
//
//class HomePageState extends State<HomePage> {
//  List<Attendee> attendees;
//
//  Future<String> getData(BuildContext context) async {
////    var response = await http.get(
////        Uri.encodeFull(
////            "https://api.meetup.com/2/rsvps?offset=0&format=json&event_id=249472955&photo-host=public&page=75&fields=&order=event&desc=false&sig_id=155262402&sig=1bf9a75b2981f2d0e83ff277334362e161e8acc3"),
////        headers: {"Accept": "application/json"});
////    var _attendees = response.body;
//    var _attendees = await DefaultAssetBundle
//        .of(context)
//        .loadString('assets/attendees.json');
//
////    this.setState(() {
//    var results = json.decode(_attendees)['results'];
//    attendees = [];
//    for (var r in results) {
//      attendees.add(Attendee.fromJson(r));
//    }
////    });
//  }
//
//  @override
//  void initState() {
//    super.initState();
//    this.getData(context);
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("Attendees"),
//      ),
//      body: attendees == null
//          ? Text("Loading")
//          : AttendeeList(attendees, (a) => print(a.name)),
//    );
//  }
//}
