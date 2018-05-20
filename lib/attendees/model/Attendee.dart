import 'package:cloud_firestore/cloud_firestore.dart';

class Attendee {
  final String documentId;
  final String name;
  final String imageUrl;
  bool isAttending;
  final bool meetupRsvp;

  Attendee(this.documentId, this.name, this.imageUrl, this.isAttending,
      this.meetupRsvp);

  factory Attendee.fromQuery(DocumentSnapshot snapshot) {
    var id = snapshot.documentID;
    var name = snapshot.data['name'];
    var photoUrl = snapshot.data['photoUrl'];
    var attending = snapshot.data['attending'];

    return Attendee(id, name, photoUrl, attending, true);
  }

  factory Attendee.fromJson(Map<String, dynamic> json) {
    var imageUrl;
    var memberPhoto = json['member_photo'];
    if (memberPhoto != null) {
      imageUrl = memberPhoto['photo_link'];
    }

    var name;
    var member = json['member'];
    if (member != null) {
      name = member['name'];
    }
    return Attendee("fakeDoc", name, imageUrl, false, false);
  }

  Map<String, dynamic> toMap() => {
        "name": name,
        "photoUrl": imageUrl,
        "attending": isAttending,
        "meetup_rsvp": meetupRsvp
      };
}
