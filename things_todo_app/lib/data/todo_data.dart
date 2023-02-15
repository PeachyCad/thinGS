import 'package:flutter/material.dart';
import 'package:things_todo_app/models/task.dart';
import 'package:things_todo_app/models/todo.dart';

class ToDoData extends ChangeNotifier {
  List<ToDo> todoList = [
    ToDo(name: "ToDo 1", tasks: [
      Task(
        name: "Task 1-1",
        description: "Do this",
      ),
      Task(
        name: "Task 1-2",
        description: "Do this again",
      ),
    ]),
    ToDo(name: "ToDo 2", tasks: [
      Task(
        name: "Task 2-1",
        description: "Do",
      ),
      Task(
        name: "Task 1-2",
        description: "Do this again-again",
      ),
    ]),
  ];

  List<ToDo> getToDoList() {
    return todoList;
  }

  ToDo findToDo(String todoName) {
    return todoList.firstWhere((todo) => todo.name == todoName);
  }

  Task findTask(String todoName, String taskName) {
    var foundToDo = findToDo(todoName);
    return foundToDo.tasks.firstWhere((task) => task.name == taskName);
  }

  void changeTaskStatus(String todoName, String taskName) {
    var foundTask = findTask(todoName, taskName);
    foundTask.isCompleted = !foundTask.isCompleted;

    notifyListeners();
  }

  void addToDo(String name) {
    todoList.add(ToDo(name: name, tasks: []));

    notifyListeners();
  }

  void addTask(String todoName, String taskName, String description) {
    var foundToDo = findToDo(todoName);

    foundToDo.tasks.add(
      Task(
        name: todoName,
        description: description,
      ),
    );

    notifyListeners();
  }

  int amountOfTasksInToDo(String todoName) {
    var foundToDo = findToDo(todoName);
    return foundToDo.tasks.length;
  }
}
