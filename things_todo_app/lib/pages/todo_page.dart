import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:things_todo_app/components/task_listview.dart';
import 'package:things_todo_app/models/task.dart';
import 'home_page.dart';

class ToDoPage extends ConsumerWidget {
  final String todoName;
  final int todoIndex;
  final newTaskNameController = TextEditingController();
  final newTaskDescriptionController = TextEditingController();

  ToDoPage({super.key, required this.todoName, required this.todoIndex});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Task> tasks = ref.watch(todoProvider).findToDo(todoIndex).tasks;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          todoName,
          style: const TextStyle(fontFamily: 'RobotoMono'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Create New Task"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: newTaskNameController,
                    decoration: const InputDecoration(hintText: "Task Name"),
                  ),
                  TextField(
                    controller: newTaskDescriptionController,
                    decoration:
                        const InputDecoration(hintText: "Task Description"),
                  ),
                ],
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    var newTaskName = newTaskNameController.text;
                    var newTaskDescription = newTaskDescriptionController.text;
                    if (newTaskName.trim().isNotEmpty)
                      ref
                          .read(todoProvider)
                          .addTask(todoIndex, newTaskName, newTaskDescription);

                    newTaskNameController.clear();
                    newTaskDescriptionController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text("Save"),
                ),
                MaterialButton(
                  onPressed: () {
                    newTaskNameController.clear();
                    newTaskDescriptionController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                )
              ],
            ),
          );
        },
        child: const Icon(Icons.add_rounded),
      ),
      body: Center(
        child: TaskListView(
          todoIndex: todoIndex,
          tasks: tasks,
        ),
      ),
    );
  }
}
