import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String name;
  final String surname;
  final String photoUrl;
  final String email;
  final String password;
  final String uid;

  const User(
      {required this.name,
      required this.surname,
      required this.photoUrl,
      required this.email,
      required this.password,
      required this.uid});

  Map<String, dynamic> toJson() => {
        "Name": name,
        "Surname": surname,
        "email": email,
        "password": password,
        "photoUrl": photoUrl,
        "uid": uid,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
        name: snapshot['Name'],
        surname: snapshot['Surname'],
        photoUrl: snapshot['photoUrl'],
        email: snapshot['email'],
        password: snapshot['password'],
        uid: snapshot['uid']);
  }
}
