import 'package:flutter/material.dart';
import 'package:todoapp/button.dart';


class DialogBox extends StatelessWidget {

 final VoidCallback onSave;
 final VoidCallback onCancel;

  final TextEditingController controller;
  const DialogBox({super.key,
  required this.controller,
  required this.onSave,
  required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromRGBO(72, 74, 74, 1),
      content: SizedBox(
        height: 150,
        width: 150,
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            TextField(
              style: TextStyle(
                color: Colors.white
              ),
              controller: controller,
              decoration: InputDecoration(
                
                border: OutlineInputBorder(),
                
                
                label:Text( 'Add a New task'),
                labelStyle: TextStyle(
                  color: Colors.white
                )
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(onPressed: onCancel, text: 'Cancel'),
                MyButton(onPressed: onSave, text: 'Save',),
                
              ],
            )
          ],
        ),
      ),
      


    );
  }
}