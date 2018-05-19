import 'package:cloud_firestore/cloud_firestore.dart';

class Attendee {
  final String documentId;
  final String name;
  final String imageUrl;

  Attendee(this.documentId, this.name, this.imageUrl);

  factory Attendee.fromQuery(DocumentSnapshot snapshot) {
    var id = snapshot.documentID;
    var name = snapshot.data['name'];
    var photoUrl = snapshot.data['photoUrl'];

    return Attendee(id, name, photoUrl);
  }

  factory Attendee.fromJson(Map<String, dynamic> json) {
    var imageUrl;
    var memberPhoto = json['member_photo'];
    if (memberPhoto != null) {
      imageUrl = memberPhoto['thumb_link'];
    }

    var name;
    var member = json['member'];
    if (member != null) {
      name = member['name'];
    }
    return Attendee("fakeDoc", name, imageUrl);
  }
}
