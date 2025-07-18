import 'package:flutter/material.dart';
import 'package:todoapp/button.dart';


class DialogBox extends StatefulWidget {

 final VoidCallback onSave;
 final VoidCallback onCancel;
 

  final TextEditingController controller;
   const DialogBox({super.key,
  required this.controller,
  required this.onSave,
  required this.onCancel,
  
  });

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
String? errorText;

void validateAndSave(){
  if (widget.controller.text.trim().isEmpty){
    setState(() {
      errorText = "Please Enter a task";
    });
  }else{
    setState(() {
      errorText=null;
    });
    widget.onSave();
  }
}

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromRGBO(72, 74, 74, 1),
      content: SizedBox(
        height: 150,
        width: double.infinity,
          child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(
              height: 10,
            ),
            TextField(
              autofocus: true,
              maxLines: 1,
              
              controller: widget.controller,
              onChanged: (value){
                if (errorText != null && value.trim().isNotEmpty){
                  setState(() {
                    errorText=null;
                  });
                }
              },
              style: TextStyle(
                color: Colors.white
              ),
             
              decoration: InputDecoration(
                errorText:errorText,
                border: OutlineInputBorder(),
                label:Text( 'Add a New task'),
                labelStyle: TextStyle(
                  color: Colors.white
                )
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(onPressed: widget.onCancel, text: 'Cancel'),
                MyButton(onPressed: validateAndSave, text: 'Save',),
                
              ],
            )
          ],
        ),
      ),
      


    );
  }
}