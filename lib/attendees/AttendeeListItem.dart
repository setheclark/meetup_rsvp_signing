import 'package:flutter/material.dart';
import 'package:meetup_event_signin/attendees/model/Attendee.dart';

typedef void AttendeeClicked(Attendee a);

class AttendeeListItem extends StatelessWidget {
  final Attendee _attendee;
  final AttendeeClicked onTap;

  AttendeeListItem(this._attendee, this.onTap);

  @override
  Widget build(BuildContext context) {
    var avatar = _attendee.imageUrl != null
        ? CircleAvatar(
            radius: 20.0,
            backgroundImage: NetworkImage(
              _attendee.imageUrl,
            ),
          )
        : null;
    return Card(
      child: ListTile(
        onTap: () => onTap(_attendee),
        leading: avatar,
        title: Text(
          _attendee.name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
