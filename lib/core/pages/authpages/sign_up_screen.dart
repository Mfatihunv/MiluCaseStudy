import 'dart:typed_data';

import 'package:casestudy/core/navbar.dart';
import 'package:casestudy/core/pages/authpages/login_screen.dart';
import 'package:casestudy/core/pages/homepage.dart';
import 'package:casestudy/core/services/service.dart';
import 'package:casestudy/core/utils/image_utils.dart';
import 'package:casestudy/core/widgets/customtextf_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailCont = TextEditingController();
  final TextEditingController _passwordCont = TextEditingController();
  final TextEditingController _nameCont = TextEditingController();
  final TextEditingController _surnameCont = TextEditingController();
  bool _isLoading = false;
  Uint8List? _image;
  @override
  void dispose() {
    _emailCont.dispose();
    _nameCont.dispose();
    _surnameCont.dispose();
    _passwordCont.dispose();
    super.dispose();
  }

  Future<void> selectedImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Case Study',
              style: TextStyle(fontSize: 30, color: Colors.black),
            ),
            SizedBox(
              height: 30,
            ),
            Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 64,
                        backgroundImage: MemoryImage(_image!),
                      )
                    : CircleAvatar(
                        radius: 64,
                        backgroundImage: NetworkImage(
                            "https://media.istockphoto.com/id/1073173288/tr/vekt%C3%B6r/profil-foto%C4%9Fraf-kullan%C4%B1c%C4%B1-simgesi.jpg?s=170667a&w=0&k=20&c=Lv3u4_hLIMcWP5erxrSZmgji3wO59JbrfupnX71Q4Yg="),
                      ),
                Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                        onPressed: selectedImage,
                        color: Colors.black,
                        icon: Icon(Icons.add_a_photo_rounded)))
              ],
            ),
            Center(
              child: Text("Fotoğrafınızı Ekleyin (Zaruri)"),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: CustomTextField(
                  controller: _emailCont,
                  hintText: "Mailiniz",
                  textInputType: TextInputType.emailAddress),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: CustomTextField(
                  isPass: true,
                  controller: _passwordCont,
                  hintText: "Şifreniz",
                  textInputType: TextInputType.text),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: CustomTextField(
                  controller: _nameCont,
                  hintText: "İsminiz",
                  textInputType: TextInputType.text),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: CustomTextField(
                  controller: _surnameCont,
                  hintText: "Soyisminiz",
                  textInputType: TextInputType.text),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () async {
                setState(() {
                  _isLoading = true;
                });
                String res = await AuthMethods().signUpUser(
                    email: _emailCont.text,
                    password: _passwordCont.text,
                    name: _nameCont.text,
                    surname: _surnameCont.text,
                    file: _image!);
                setState(() {
                  _isLoading = false;
                });
                if (res != 'success') {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => NavBar()));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Kayıt sırasında bir sorun oluştu')));
                }
              },
              child: Container(
                child: _isLoading
                    ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Text(
                        'Kayıt Ol',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                height: screenHeight * .08,
                width: screenWidth * .25,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue),
              ),
            ),
            SizedBox(
              height: 12,
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
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ));
                  },
                  child: Container(
                    child: Text(
                      "Giriş Yap !",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
