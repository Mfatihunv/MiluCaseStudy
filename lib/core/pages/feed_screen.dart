import 'dart:typed_data';

import 'package:casestudy/core/pages/profile_screen.dart';
import 'package:casestudy/core/utils/image_utils.dart';
import 'package:casestudy/core/widgets/appbar.dart';
import 'package:casestudy/core/widgets/post_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppbar("Milu", false, context),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('posts').snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (ctx, index) => Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 15,
                ),
                child: PostCard(
                  snap: snapshot.data!.docs[index].data(),
                ),
              ),
            );
          },
        ),
      ),
    );
    ;
  }
}
