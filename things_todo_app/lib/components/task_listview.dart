import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:things_todo_app/components/text_fragment.dart';
import 'package:things_todo_app/models/task.dart';
import 'package:things_todo_app/models/todo.dart';
import 'package:things_todo_app/pages/home_page.dart';
import 'package:things_todo_app/pages/todo_page.dart';

class TaskListView extends ConsumerStatefulWidget  {
  final List<Task> tasks;

  const TaskListView({
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
      itemBuilder: (context, index) => ListTile(
        title: TextFragment(text: widget.tasks[index].name),
        subtitle: TextFragment(text: widget.tasks[index].description)
      ),
      physics: const BouncingScrollPhysics(),
    );
  }
}