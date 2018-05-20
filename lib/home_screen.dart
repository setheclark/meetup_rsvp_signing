import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meetup_event_signin/attendee_data.dart';
import 'package:meetup_event_signin/globals.dart' as globals;
import 'package:meetup_event_signin/rsvp_list_screen.dart';

class HomeScreen extends StatelessWidget {
  final CollectionReference rsvpRef = Firestore.instance
      .collection(globals.EVENTS_COLLECTION)
      .document(globals.EVENT_NAME)
      .collection(globals.RSVP_COLLECTION);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SizedBox(
          child: Column(
            children: <Widget>[
              Text("Did you RSVP on Meetup.com?"),
              Padding(
                child: RaisedButton(
                  child: Text("Yes"),
                  onPressed: () {
                    showRsvpList(context);
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

  void showRsvpList(BuildContext context) async {
    await Navigator.of(context).push(
          MaterialPageRoute<Attendee>(
              builder: (context) => RsvpListPage(rsvpRef)),
        );

    Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text("You're not signed in.  Enjoy the event"),
          ),
        );
  }
}
