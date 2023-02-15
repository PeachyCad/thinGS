import 'package:flutter/material.dart';
import 'package:things_todo_app/models/todo.dart';

class ToDoListView extends StatelessWidget {
  final List<ToDo> todoList;

  const ToDoListView({
    required this.todoList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) => ListTile(
              title: Text(todoList[index].name),
            ));
  }
}
