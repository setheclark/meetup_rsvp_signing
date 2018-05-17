import 'package:flutter/material.dart';
import 'package:meetup_event_signin/attendees/AttendeeListItem.dart';
import 'package:meetup_event_signin/attendees/model/Attendee.dart';

class AttendeeList extends StatelessWidget {
  final List<Attendee> _attendees;
  final AttendeeClicked itemTapped;

  AttendeeList(this._attendees, this.itemTapped);

  @override
  Widget build(BuildContext context) {
    return new ListView(
      children: _buildAttendeesList(),
    );
  }

  List<AttendeeListItem> _buildAttendeesList() {
    return _attendees
        .map((attendee) => new AttendeeListItem(attendee, itemTapped))
        .toList();
  }
}
