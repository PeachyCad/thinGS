import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:things_todo_app/components/text_fragment.dart';
import 'package:things_todo_app/models/task.dart';
import 'package:things_todo_app/pages/home_page.dart';

import 'edit_delete_buttons.dart';

class TaskListView extends ConsumerStatefulWidget  {
  final int todoIndex;
  final List<Task> tasks;
  final newTaskNameController = TextEditingController();
  final newTaskDescriptionController = TextEditingController();

  TaskListView({
    required this.todoIndex,
    required this.tasks,
    super.key,
  });

  @override
  ConsumerState<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends ConsumerState<TaskListView> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.tasks.length,
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
                      text: widget.tasks[index].name, 
                      isOverflowClip: true,
                    ),
                    const SizedBox(height: 10),
                    TextFragment(
                      text: widget.tasks[index].description, 
                      isOverflowClip: true,
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
                        title: const Text("Edit Task Text"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: widget.newTaskNameController,
                              decoration: const InputDecoration(
                                hintText: "Task Name"
                              ),
                            ),
                            TextField(
                              controller: widget.newTaskDescriptionController,
                              decoration: const InputDecoration(
                                hintText: "Task Description"
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          MaterialButton(
                            onPressed: () {
                              var newTaskName = widget.newTaskNameController.text;
                              var newTaskDescription = widget.newTaskDescriptionController.text;
                              if(newTaskName.trim().isNotEmpty) ref.read(todoProvider).changeTaskText(widget.todoIndex, index, newTaskName, newTaskDescription);

                              widget.newTaskNameController.clear();
                              widget.newTaskDescriptionController.clear();
                              Navigator.pop(context);
                            },
                            child: const Text("Save"),
                          ),
                          MaterialButton(
                            onPressed: () {
                              widget.newTaskNameController.clear();
                              widget.newTaskDescriptionController.clear();
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel"),
                          )
                        ],
                      ),
                    );
                  },
                  onPressedDelete: () =>
                      ref.read(todoProvider).deleteTask(widget.todoIndex, index)),
            ],
          ),
        ),
      ),

      // itemBuilder: (context, index) => ListTile(
      //   title: TextFragment(text: widget.tasks[index].name),
      //   subtitle: TextFragment(text: widget.tasks[index].description)
      // ),
      physics: const BouncingScrollPhysics(),
    );
  }
  @override
  void dispose() {
    widget.newTaskNameController.dispose();
    widget.newTaskDescriptionController.dispose();
    super.dispose();
  }
}