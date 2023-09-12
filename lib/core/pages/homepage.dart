import 'package:casestudy/core/pages/authpages/login_screen.dart';
import 'package:casestudy/core/providers/provider.dart';
import 'package:casestudy/core/widgets/logout_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:casestudy/core/models/user_model.dart' as model;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  void initState() {
    addData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80, // Fotoğrafı daha büyük yap
              backgroundColor: Colors.black, // Border rengi
              child: CircleAvatar(
                radius: 75, // İçerideki fotoğrafı daha büyük yap
                backgroundImage: NetworkImage(user.photoUrl),
              ),
            ),
            SizedBox(height: 20), // Araya boşluk ekleyin
            Text(
              "${user.name} ${user.surname}",
              style: TextStyle(
                fontSize: 24, // İsim ve soyisimi büyütün
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "${user.email}",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut().then((_) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ));
                }).catchError((error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Çıkış yaparken hata oluştu.')));
                });
              },
              child: Text(
                "Çıkış Yap",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
