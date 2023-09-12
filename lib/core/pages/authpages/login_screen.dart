import 'package:casestudy/core/navbar.dart';
import 'package:casestudy/core/pages/homepage.dart';
import 'package:casestudy/core/pages/authpages/sign_up_screen.dart';
import 'package:casestudy/core/widgets/customtextf_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailCont = TextEditingController();
  final TextEditingController _passwordCont = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailCont.dispose();
    _passwordCont.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Container(),
            flex: 2,
          ),
          Text(
            'Milu Case Study',
            style: TextStyle(fontSize: 30, color: Colors.black),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: CustomTextField(
                controller: _emailCont,
                hintText: "Mailiniz",
                textInputType: TextInputType.emailAddress),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: CustomTextField(
                isPass: true,
                controller: _passwordCont,
                hintText: "Şifreniz",
                textInputType: TextInputType.emailAddress),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              setState(() {
                _isLoading = true;
              });
              loginUserEmailAndPassword(
                  email: _emailCont.text, password: _passwordCont.text);
              setState(() {
                _isLoading = false;
              });
            },
            child: Container(
              child: _isLoading
                  ? CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Text(
                      'Giriş Yap',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
              height: screenHeight * .08,
              width: screenWidth * .25,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.blue),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Flexible(
            child: Container(),
            flex: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  "Hesabınız yok mu ?",
                  style: TextStyle(fontSize: 16),
                ),
                padding: EdgeInsets.symmetric(vertical: 8),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpScreen(),
                      ));
                },
                child: Container(
                  child: Text(
                    "Kayıt ol !",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  Future<void> loginUserEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      FirebaseAuth _auth = FirebaseAuth.instance;
      var _userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((kullanici) => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NavBar(),
              )));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Girmiş olduğunuz Maile ait Kullanıcı bulunamadı.')));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text('Girmiş olduğunuz kullanıcıya ait şifre yanlıştır.')));
      }
    }
  }
}
