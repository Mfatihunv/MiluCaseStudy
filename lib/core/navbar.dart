// ignore_for_file: avoid_redundant_argument_values

import 'package:casestudy/core/pages/add_post.dart';
import 'package:casestudy/core/pages/feed_screen.dart';
import 'package:casestudy/core/pages/homepage.dart';
import 'package:casestudy/core/pages/share.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  //todo We need to add other page on buildScreen func. When we add other page we should change NavBarStyle from 2 to 16
  List<Widget> buildScreen() {
    return [
      const AddPostScreen(),
      const FeedScreen(),
      const ProfilePage(),
    ];
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildScreen()[selectedIndex],
      bottomNavigationBar: SnakeNavigationBar.color(
        backgroundColor: Color(0xFF045B80),
        behaviour: SnakeBarBehaviour.pinned,
        snakeShape: SnakeShape.indicator,
        snakeViewColor: Colors.white,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.upload)),
          BottomNavigationBarItem(icon: Icon(Icons.home)),
          BottomNavigationBarItem(icon: Icon(Icons.person)),
        ],
      ),
    );
  }
}
