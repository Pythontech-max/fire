import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextfeild extends StatelessWidget {
  CustomTextfeild(
      {Key? key,
      required this.controller,
      required this.iconData,
      required this.hinttext})
      : super(key: key);
  final TextEditingController controller;
  final IconData iconData;
  final String hinttext;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(20)),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(iconData),
              hintText: hinttext),
        ),
      ),
    );
  }
}
