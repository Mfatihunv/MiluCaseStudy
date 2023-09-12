import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  final FocusNode? nextFocusNode; // Yeni bir FocusNode ekleyin

  const CustomTextField({
    Key? key,
    required this.controller,
    this.isPass = false,
    required this.hintText,
    required this.textInputType,
    this.nextFocusNode, // nextFocusNode'u constructor'a ekleyin
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: EdgeInsets.all(8),
      ),
      keyboardType: textInputType,
      obscureText: isPass,
      onFieldSubmitted: (value) {
        if (nextFocusNode != null) {
          FocusScope.of(context)
              .requestFocus(nextFocusNode); // Bir sonraki alanı odaklayın
        }
      },
    );
  }
}
