import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meetup_event_signin/attendees/AttendeeList.dart';
import 'package:meetup_event_signin/attendees/model/Attendee.dart';
import 'package:meetup_event_signin/globals.dart' as globals;

class RsvpListPage extends StatelessWidget {
  final List<Attendee> attendees;

  RsvpListPage(this.attendees);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendees"),
      ),
      body: attendees == null
          ? Text("Loading")
          : AttendeeList(attendees, (a) => showConfirmationDialog(context, a)),
    );
  }

  void showConfirmationDialog(BuildContext context, Attendee a) async {
    if (await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: AlertDialog(
              title: Text("Sign in"),
              content: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage: NetworkImage(
                      a.imageUrl,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      a.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("No"),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                FlatButton(
                  child: Text("Yes"),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                )
              ],
            ),
          );
        })) {
      a.isAttending = true;
      print(a.documentId);
      await Firestore.instance
          .collection(globals.EVENTS_COLLECTION)
          .document(globals.EVENT_NAME)
          .collection(globals.RSVP_COLLECTION)
          .document(a.documentId)
          .setData(a.toMap());
      Navigator.of(context).pop(a);
    }
  }
}
