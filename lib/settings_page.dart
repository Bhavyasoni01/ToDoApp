import 'package:flutter/material.dart';


class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(child: Text('Settings',
        style: TextStyle(
          color: Colors.white
        ),)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: Container(
          height: 90,
          width: double.infinity,
          color: Color.fromRGBO(72, 74, 74, 1),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Change Font Size',
            style: TextStyle(
              color: Colors.white,
              fontSize: 19
            ),),
          ),
        ),
      ),
    );
  }
}