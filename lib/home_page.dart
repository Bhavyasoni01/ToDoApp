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
    
    // Initialize box and database after ensuring they're available
    _myBox = Hive.box('myBox');
    db = ToDoDatabase();

    if (_myBox.get('TODOLIST') == null){
      db.createData();
    }
    else{
      db.loadData();
    }
  }

  void taskComplete(index){
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];

    });
  }



  void savetask(){
    setState(() {
      db.toDoList.add([_controller.text, false]);
      // Sort the list: incomplete tasks first, completed tasks last
      db.toDoList.sort((a, b) => a[1] == b[1] ? 0 : (a[1] ? 1 : -1));
      _controller.clear(); // Clear the text field
      Navigator.of(context).pop();
    });
    db.updateData();
  }

  void cancelTask(){
    setState(() {
      _controller.clear(); // Clear the text field
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
        actions: [
          IconButton(
          onPressed: (){
             Text('Coming Soon');
          }, 
        icon: Icon(Icons.settings,
        color: Colors.white,)) 
        ],
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
        );
      }
    ),

    

    );
  }
}