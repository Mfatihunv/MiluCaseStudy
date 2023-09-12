import 'package:casestudy/core/pages/authpages/login_screen.dart';
import 'package:casestudy/core/pages/authpages/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LogoutWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Firebase Authentication kullanarak çıkış yap
        FirebaseAuth.instance.signOut().then((_) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ));
        }).catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Çıkış yaparken hata oluştu.')));
        });
      },
      child: Row(
        children: [
          Icon(Icons.exit_to_app),
          SizedBox(width: 8),
          Text("Logout"),
        ],
      ),
    );
  }
}
