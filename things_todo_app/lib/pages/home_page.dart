import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:things_todo_app/data/todo_data.dart';
import 'package:things_todo_app/models/todo.dart';
import '../components/todo_listview.dart';

final todoProvider = ChangeNotifierProvider((ref) => ToDoData());

class HomePage extends ConsumerWidget {
  HomePage({super.key});
  final newToDoNameController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<ToDo> todoList = ref.watch(todoProvider).todoList;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Create New ToDo"),
              content: TextField(
                controller: newToDoNameController,
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    var newToDoName = newToDoNameController.text;
                    ref.read(todoProvider).addToDo(newToDoName);

                    newToDoNameController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text("Save"),
                ),
                MaterialButton(
                  onPressed: () {
                    newToDoNameController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                )
              ],
            ),
          );
        },
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: ToDoListView(
          todoList: todoList,
        ),
      ),
    );
  }
}
