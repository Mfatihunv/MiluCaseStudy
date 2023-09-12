import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String headertext;
  final String uid;
  final String username;
  final String usersurname;
  final String postId;
  final DateTime datePublished;
  final String postUrl;
  final String profImage;

  const Post({
    required this.headertext,
    required this.description,
    required this.uid,
    required this.username,
    required this.usersurname,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.profImage,
  });

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
        description: snapshot["description"],
        uid: snapshot["uid"],
        headertext: snapshot["headertext"],
        postId: snapshot["postId"],
        datePublished: snapshot["datePublished"],
        username: snapshot["username"],
        usersurname: snapshot["usersurname"],
        postUrl: snapshot['postUrl'],
        profImage: snapshot['profImage']);
  }

  Map<String, dynamic> toJson() => {
        "description": description,
        "uid": uid,
        "headertext": headertext,
        "username": username,
        "usersurname": usersurname,
        "postId": postId,
        "datePublished": datePublished,
        'postUrl': postUrl,
        'profImage': profImage
      };
}
