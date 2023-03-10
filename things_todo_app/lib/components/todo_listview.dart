import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:things_todo_app/components/text_fragment.dart';
import 'package:things_todo_app/models/todo.dart';
import 'package:things_todo_app/pages/home_page.dart';
import 'package:things_todo_app/pages/todo_page.dart';

import 'edit_delete_buttons.dart';

class ToDoListView extends ConsumerStatefulWidget {
  final List<ToDo> todoList;
  final newToDoNameController = TextEditingController();

  ToDoListView({
    required this.todoList,
    super.key,
  });

  @override
  ConsumerState<ToDoListView> createState() => _ToDoListViewState();
}

class _ToDoListViewState extends ConsumerState<ToDoListView> {
  void goToToDoList(String todoName, int todoIndex) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) =>
            ToDoPage(todoName: todoName, todoIndex: todoIndex),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.todoList.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 25, 20, 25),
          decoration: BoxDecoration(
              color: Colors.indigo, borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFragment(
                      text: widget.todoList[index].name,
                      isOverflowClip: false,
                    ),
                    const SizedBox(height: 10),
                    TextFragment(
                      text:
                          'Tasks: ${widget.todoList[index].tasks.length.toString()}',
                      isOverflowClip: false,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              EditDeleteButtons(
                  onPressedEdit: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Edit ToDo Name"),
                        content: TextField(
                          controller: widget.newToDoNameController,
                          decoration:
                              const InputDecoration(hintText: "ToDo Name"),
                        ),
                        actions: [
                          MaterialButton(
                            onPressed: () {
                              var newToDoName =
                                  widget.newToDoNameController.text;
                              if (newToDoName.trim().isNotEmpty) {
                                ref
                                    .read(todoProvider)
                                    .changeToDo(index, newToDoName);
                              }

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
                  onPressedDelete: () =>
                      ref.read(todoProvider).deleteToDo(index)),
              IconButton(
                  icon: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 30,
                  ),
                  color: Colors.white,
                  onPressed: () =>
                      goToToDoList(widget.todoList[index].name, index)),
            ],
          ),
        ),
      ),
      physics: const BouncingScrollPhysics(),
    );
  }

  @override
  void dispose() {
    widget.newToDoNameController.dispose();
    super.dispose();
  }
}
