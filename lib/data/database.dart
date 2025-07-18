import 'package:hive/hive.dart';

class ToDoDatabase {
  List toDoList = [];
  late Box _myBox;

  ToDoDatabase() {
    _myBox = Hive.box('myBox');
  }

  void createData() {
    toDoList = [
      ['Welcome', false],
      ['Swipe Right to mark the task completed', false]
    ];
  }

  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  void updateData() {
    _myBox.put('TODOLIST', toDoList);
  }
}