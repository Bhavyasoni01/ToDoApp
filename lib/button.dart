import 'dart:math';

import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  VoidCallback onPressed;
  final String text;
   MyButton({super.key,
  required this.onPressed,
  required this.text});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 12,
      shape: RoundedRectangleBorder(),
      onPressed: onPressed,
      child: Text(text,
      style: TextStyle(
        color: text == 'Cancel'? Colors.red : 
        Colors.black
      )),);
  }
}