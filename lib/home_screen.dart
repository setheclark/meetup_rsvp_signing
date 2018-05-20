import 'package:flutter/material.dart';
import 'package:meetup_event_signin/attendees/model/Attendee.dart';
import 'package:meetup_event_signin/rsvp_list_screen.dart';

class HomeScreen extends StatefulWidget {
  final List<Attendee> _attendees;

  HomeScreen(this._attendees);

  @override
  State<StatefulWidget> createState() => _HomeState(_attendees);
}

class _HomeState extends State<HomeScreen> {
  final List<Attendee> _attendees;

  _HomeState(this._attendees);

  void showRsvpList() async {
    var attendingRsvp = await Navigator.of(context).push(
          MaterialPageRoute<Attendee>(
              builder: (context) => RsvpListPage(_attendees)),
        );

    if (attendingRsvp != null) {
      //TODO Remove from firestore
      setState(() {});
      _attendees.remove(attendingRsvp);
    }
  }

  void showManualEntry() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          child: Column(
            children: <Widget>[
              Text("Did you RSVP on Meetup.com?"),
              Padding(
                child: RaisedButton(
                  child: Text("Yes"),
                  onPressed: () {
                    showRsvpList();
                  },
                ),
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
              RaisedButton(
                child: Text("No"),
                onPressed: () {
                  print("");
                },
              )
            ],
          ),
          width: 200.0,
          height: 300.0,
        ),
      ),
    );
  }
}
