import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:things_todo_app/data/todo_data.dart';
import 'package:things_todo_app/models/todo.dart';
import '../components/todo_listview.dart';

final todoProvider = ChangeNotifierProvider((ref) => ToDoData());

class HomePage extends ConsumerStatefulWidget {
  HomePage({super.key});
  final newToDoNameController = TextEditingController();

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();

    ref.read(todoProvider).initializeToDoList();
  }

  @override
  Widget build(BuildContext context) {
    List<ToDo> todoList = ref.watch(todoProvider).todoList;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true, // this is all you need
        title: const Text(
          "thinGS",
          style: TextStyle(fontFamily: 'RobotoMono'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Create New ToDo"),
              content: TextField(
                controller: widget.newToDoNameController,
                decoration: const InputDecoration(
                      hintText: "ToDo Name"
                ),
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    var newToDoName = widget.newToDoNameController.text;
                    if(newToDoName.trim().isNotEmpty) ref.read(todoProvider).addToDo(newToDoName);

                    widget.newToDoNameController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text("Save"),
                ),
                MaterialButton(
                  onPressed: () {
                    widget.newToDoNameController.clear();
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
        child: ToDoListView(
          todoList: todoList,
        ),
      ),
    );
  }
  
  @override
  void dispose() {
    widget.newToDoNameController.dispose();
    super.dispose();
  }
}
