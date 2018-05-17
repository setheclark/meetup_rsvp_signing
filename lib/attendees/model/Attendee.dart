class Attendee {
  final String name;
  final String imageUrl;

  Attendee(this.name, this.imageUrl);

  factory Attendee.fromJson(Map<String, dynamic> json) {
    var imageUrl;
    var memberPhoto = json['member_photo'];
    if (memberPhoto != null) {
      imageUrl = memberPhoto['thumb_link'];
//      imageUrl = memberPhoto['photo_link'];
    }

    var name;
    var member = json['member'];
    if (member != null) {
      name = member['name'];
    }
    return Attendee(name, imageUrl);
  }
}
