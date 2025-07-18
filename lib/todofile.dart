import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Todofile extends StatefulWidget {

final String taskName;
final bool taskDone;
Function(bool?)? onChanged;
Function(BuildContext)? deletefunction;
Function(BuildContext)? completeFunction;
Function(BuildContext)? editFunction;



   Todofile({super.key,
  required this.taskDone,
  required this.taskName,
  required this.onChanged,
  required this.deletefunction,
  required this.completeFunction,
  required this.editFunction,
  });

  @override
  State<Todofile> createState() => _TodofileState();
}

class _TodofileState extends State<Todofile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(), 
          children: [
            SlidableAction(
              onPressed: widget.deletefunction,
              backgroundColor: Colors.black,
              icon: Icons.delete_outline,
              borderRadius: BorderRadius.circular(25),
              flex: 12,
            ),
          ],
        ),
        startActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              autoClose: true,
              onPressed: widget.completeFunction,
              icon: Icons.done,
              backgroundColor: Colors.black,
              borderRadius: BorderRadius.circular(25),
              flex: 121,
            )
          ]
        ),
        child: GestureDetector(
          onLongPress: (){
            if(widget.editFunction != null){
              widget.editFunction!(context);
            }
          },
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              color: Color.fromRGBO(72, 74, 74, 1),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              children: [
                Checkbox(
                  value: widget.taskDone, 
                  onChanged: widget.onChanged,
                  side: const BorderSide(
                    color: Colors.white
                  ),
                  activeColor: Colors.black,
                ),
                Expanded(
                  child: Text(
                    widget.taskName,
                    
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      decoration: widget.taskDone? TextDecoration.lineThrough : TextDecoration.none
                    ),
                    softWrap: true,
                    maxLines: 3,
                    overflow: TextOverflow.visible,
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}