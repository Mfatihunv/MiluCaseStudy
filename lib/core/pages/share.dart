import 'package:flutter/material.dart';

class SharePhotoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fotoğraf Paylaş"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: () {
                // Fotoğraf seçme işlemi burada gerçekleştirilebilir
              },
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.camera_alt,
                  size: 60,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Fotoğrafını Paylaş",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Paylaşma işlemi burada gerçekleştirilebilir
              },
              child: Text("Paylaş"),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                padding: EdgeInsets.all(16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
