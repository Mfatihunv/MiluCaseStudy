import 'package:casestudy/core/models/user_model.dart' as model;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final model.User user; // User modelini burada kullanacağız

  ProfileScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user.photoUrl),
            ),
            SizedBox(height: 20),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Çıkış yapma işlemi
                FirebaseAuth.instance.signOut();
              },
              child: Text("Çıkış Yap"),
            ),
          ],
        ),
      ),
    );
  }
}
