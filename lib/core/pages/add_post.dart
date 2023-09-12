import 'dart:typed_data';

import 'package:casestudy/core/providers/provider.dart';
import 'package:casestudy/core/services/service.dart';
import 'package:casestudy/core/utils/image_utils.dart';
import 'package:casestudy/core/widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  @override
  Uint8List? _file;
  bool isLoading = false;
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _headerTextController = TextEditingController();

  _selectImage(BuildContext parentContext) async {
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Post Oluştur'),
          children: <Widget>[
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Bir Fotoğraf Çek'),
                onPressed: () async {
                  Navigator.pop(context);
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                }),
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Galerinden Seç'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                }),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  void postImage(
      String uid, String username, String usersurname, String profImage) async {
    setState(() {
      isLoading = true;
    });

    try {
      // Firebase Storage'a resmi yükle
      String imageUrl = await FirebaseService().uploadPost(
        _descriptionController.text,
        _headerTextController.text,
        _file!,
        uid,
        username,
        usersurname,
        profImage,
      );

      if (imageUrl.isNotEmpty) {
        setState(() {
          isLoading = false;
        });
        if (context.mounted) {
          showSnackBar(
            context,
            'Posted!',
          );
        }
        clearImage();
      } else {
        if (context.mounted) {
          showSnackBar(context, 'Image upload failed.');
        }
      }
    } catch (err) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return _file == null
        ? Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "Yeni bir gönderi oluştur!",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: IconButton(
                    icon: const Icon(
                      Icons.upload,
                    ),
                    onPressed: () => _selectImage(context),
                  ),
                ),
              ],
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: clearImage,
              ),
              title: Text(
                'Yeni Gönderi',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      isLoading
                          ? LinearProgressIndicator()
                          : SizedBox(height: 0.0),
                      SizedBox(height: 16.0),
                      Container(
                        width: 120.0, // Fotoğrafın genişliğini ayarlayın
                        height: 120.0, // Fotoğrafın yüksekliğini ayarlayın
                        decoration: BoxDecoration(
                          shape: BoxShape.circle, // Dairesel şekil kullanın
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            alignment: FractionalOffset.topCenter,
                            image: MemoryImage(_file!),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors
                                .blue, // İlk yazı alanının kenarlık (border) rengini ayarlayın
                            width:
                                2.0, // İlk yazı alanının kenarlık (border) kalınlığını ayarlayın
                          ),
                          borderRadius: BorderRadius.circular(
                              10.0), // Köşeleri yuvarlatın
                        ),
                        child: TextField(
                          controller: _headerTextController,
                          decoration: InputDecoration(
                            hintText: "Başlığınız",
                            contentPadding: EdgeInsets.all(8.0),
                            border: InputBorder.none,
                          ),
                          maxLines: 1,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors
                                .blue, // İkinci yazı alanının kenarlık (border) rengini ayarlayın
                            width:
                                2.0, // İkinci yazı alanının kenarlık (border) kalınlığını ayarlayın
                          ),
                          borderRadius: BorderRadius.circular(
                              10.0), // Köşeleri yuvarlatın
                        ),
                        child: TextField(
                          controller: _descriptionController,
                          decoration: InputDecoration(
                            hintText: "Açıklamanız",
                            contentPadding: EdgeInsets.all(8.0),
                            border: InputBorder.none,
                          ),
                          maxLines: 4,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () => postImage(
                          userProvider.getUser.uid,
                          userProvider.getUser.name,
                          userProvider.getUser.surname,
                          userProvider.getUser.photoUrl,
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue, // Butonun rengini mavi yapar
                        ),
                        child: Text(
                          "Paylaş",
                          style: TextStyle(
                            color: Colors.white, // Yazı rengini beyaz yapar
                            fontSize: 18, // Yazıyı büyütür
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}


// Center(
//       child: IconButton(onPressed: () {}, icon: Icon(Icons.upload)),
//     );