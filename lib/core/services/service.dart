import 'dart:math';
import 'dart:typed_data';
import 'package:casestudy/core/models/post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:casestudy/core/models/user_model.dart' as model;
import 'package:uuid/uuid.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> signUpUser({
    required String email,
    required String password,
    required String name,
    required String surname,
    required Uint8List file,
  }) async {
    String res = "Sorun Oluştu";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          name.isNotEmpty ||
          surname.isNotEmpty) {
        UserCredential userinfo = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String photoUrl = await StorageServices()
            .uploadImageToStorage('profilePictures', file, false);
        print(userinfo.user!.uid);

        model.User user = model.User(
            name: name,
            surname: surname,
            photoUrl: photoUrl,
            email: email,
            password: password,
            uid: userinfo.user!.uid);

        await _firestore
            .collection('users')
            .doc(userinfo.user!.uid)
            .set(user.toJson());
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<model.User> getUserDetail() async {
    User currenUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currenUser.uid).get();

    return model.User.fromSnap(snap);
  }
}

class StorageServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // adding image to firebase storage
  Future<String> uploadImageToStorage(
      String childName, Uint8List file, bool isPost) async {
    // creating location to our firebase storage

    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);
    if (isPost) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }

    // putting in uint8list format -> Upload task like a future but not future
    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}

class FirebaseService {
  Future<String> generateUniqueFileName() async {
    final String uuid = Uuid().v4();
    final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    return 'posts/$timestamp-$uuid.jpg';
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(
      String description,
      String headertext,
      Uint8List file,
      String uid,
      String username,
      String usersurname,
      String profImage) async {
    // Rastgele bir dosya adı oluşturun
    String uniqueFileName = await generateUniqueFileName();

    String res = "Some error occurred";
    try {
      String photoUrl =
          await StorageServices().uploadImageToStorage('posts', file, true);
      String postId =
          const Uuid().v1(); // Benzersiz ID oluşturmayı bırakabilirsiniz
      Post post = Post(
        description: description,
        uid: uid,
        username: username,
        usersurname: usersurname,
        headertext: headertext,
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
        profImage: profImage,
      );
      _firestore.collection('posts').doc(postId).set(post.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}

class RandomPostGenerator {
  static final Random _random = Random();

  static String getRandomItem(List<String> list) {
    final int randomIndex = _random.nextInt(list.length);
    return list[randomIndex];
  }

  static List<String> usernames = ["ali", "ayşe", "fatma", "mehmet"];
  static List<String> usersurnames = ["yılmaz", "kara", "demir", "oğuz"];
  static List<String> headerTexts = [
    "Başlık 1",
    "Başlık 2",
    "Başlık 3",
    "Başlık 4"
  ];
  static List<String> descriptions = [
    "Açıklama 1",
    "Açıklama 2",
    "Açıklama 3",
    "Açıklama 4"
  ];
  static List<String> profImages = [
    "https://example.com/image1.png",
    "https://example.com/image2.png",
    "https://example.com/image3.png"
  ];
  static List<String> postImages = [
    "https://example.com/post-image1.png",
    "https://example.com/post-image2.png",
    "https://example.com/post-image3.png"
  ];

  static Post generateRandomPost() {
    final String headertext = getRandomItem(headerTexts);
    final String description = getRandomItem(descriptions);
    final String username = getRandomItem(usernames);
    final String usersurname = getRandomItem(usersurnames);
    final String profImage = getRandomItem(profImages);
    final String uid = getRandomItem(usernames);
    final String postId = Uuid().v4();
    final DateTime datePublished = DateTime.now();
    final String postUrl = getRandomItem(postImages);

    return Post(
      headertext: headertext,
      description: description,
      username: username,
      usersurname: usersurname,
      profImage: profImage,
      uid: uid,
      postId: postId,
      datePublished: datePublished,
      postUrl: postUrl,
    );
  }
}
