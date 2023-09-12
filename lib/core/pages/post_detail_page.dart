import 'package:casestudy/core/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatelessWidget {
  final snap;

  const DetailPage({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar("Post Detayı", true, context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Fotoğrafı göster
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 2 / 3,
              margin: EdgeInsets.all(16.0),
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  snap['postUrl'].toString(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Diğer ayrıntıları göster
            ListTile(
              leading: CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage(snap['profImage'].toString()),
              ),
              title: Text(
                "${snap['username'].toString()} ${snap['usersurname'].toString()}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                snap['description'].toString(),
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
            ),
            Text(
              DateFormat.yMMMd().format(snap['datePublished'].toDate()),
            ),
          ],
        ),
      ),
    );
  }
}
