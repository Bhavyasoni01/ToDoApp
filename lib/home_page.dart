import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todoapp/data/database.dart';
import 'package:todoapp/dialog_box.dart';
import 'package:todoapp/todofile.dart';
import 'theme_provider.dart';

class HomePage extends StatefulWidget {
   HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late Box _myBox;
  late ToDoDatabase db;



  @override
  void initState() {
    super.initState();
    
    _myBox = Hive.box('myBox');
    db = ToDoDatabase();

    if (_myBox.get('TODOLIST') == null){
      db.createData();
    }
    else{
      db.loadData();
    }
  }

  void editTask(int index){
    _controller.text = db.toDoList[index][0];

    showDialog(
    context: context, 
    builder: (context){
      return DialogBox(
        controller: _controller,
        onSave: ()=> saveEditedTask(index),
        onCancel: cancelTask,
      );
    });
  }

  void saveEditedTask(int index){
    setState(() {
      if(_controller.text.trim().isEmpty){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Please Enter task"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
        );
        return;

      }
      db.toDoList[index][0]=_controller.text.trim();
      _controller.clear();
      Navigator.of(context).pop();
    });
    db.updateData();
  }

  void taskComplete(index){
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];

    });
  }



  void savetask(){
    setState(() {
      if(_controller.text.trim().isEmpty){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Please Enter task"),
            backgroundColor: Colors.red[400],
            duration: Duration(seconds: 2)   
            ));
          return;
      }
      db.toDoList.add([_controller.text, false]);
      db.toDoList.sort((a, b) => a[1] == b[1] ? 0 : (a[1] ? 1 : -1));
      _controller.clear(); 
      Navigator.of(context).pop();
    });
    db.updateData();
  }

  void cancelTask(){
    setState(() {
      _controller.clear();
      Navigator.of(context).pop();
    });
    db.updateData();
  }

  final _controller = TextEditingController();

  void createnewTask(){
    showDialog(context: context, builder: (context){
      return DialogBox(
        controller: _controller,
        onSave: savetask ,
        onCancel: cancelTask,
      );
    });

  }

  void deleteTask(int index){
      setState(() {
        db.toDoList.removeAt(index);
      });
      db.updateData();
    }
  

  void checkboxChecked(bool? value, int index){
    setState(() {
      db.toDoList[index][1] = ! db.toDoList[index][1];
      db.toDoList.sort((a, b) => a[1] == b[1] ? 0 : (a[1] ? 1 : -1));
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: Text('Tasks',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
          ),
        ),
      ),

     floatingActionButton: FloatingActionButton(onPressed: (){
      createnewTask();
     },
     child: Icon(Icons.add,
     size: 32,),
     ),

    body: db.toDoList.isEmpty ?
    Center(
      child: Text("No tasks, Create a task to get started",
      style: TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontWeight: FontWeight.bold
      ),),
    )

    
    :ListView.builder(
      itemCount: db.toDoList.length,
      itemBuilder: (context, index){
        return Todofile(
          key: ValueKey(index),
          onChanged: (value) => checkboxChecked(value, index),
          taskDone: db.toDoList[index][1],
          taskName: db.toDoList[index][0],
          deletefunction: (context) => deleteTask(index),
          completeFunction: (context) {
            setState(() {
              db.toDoList[index][1] = !db.toDoList[index][1];
              db.toDoList.sort((a, b) => a[1] == b[1] ? 0 : (a[1] ? 1 : -1));
            });
            db.updateData();
          },
          editFunction: (context)=>editTask(index),
        );
      }
    ),

    

    );
  }
}