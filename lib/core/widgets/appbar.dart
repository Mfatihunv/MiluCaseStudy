import 'package:flutter/material.dart';

AppBar customAppbar(String title, bool back, BuildContext context) {
  return AppBar(
    title: Text(
      title,
      style: const TextStyle(color: Colors.black),
    ),
    titleSpacing: 00.0,
    leading: back
        ? IconButton(
            icon: const Icon(Icons.arrow_back_sharp, color: Colors.black),
            tooltip: 'Menu Icon',
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        : SizedBox(),
    centerTitle: true,
    toolbarHeight: 60,
    toolbarOpacity: 0.8,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
    ),
    elevation: 0.00,
    backgroundColor: Colors.transparent,
  );
}
