import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task_model.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback onBookmark;
  final VoidCallback onImportant;
  final VoidCallback onDelete;

  const TaskTile({super.key, required this.task, required this.onBookmark,
    required this.onImportant, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 10),
      // shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(task.title),
        subtitle: Text(task.isBookmarked && task.completedAt != null
            ? "Completed at: ${DateFormat('hh:mm a').format(task.completedAt!)}"
            : "Created at: ${DateFormat('hh:mm a').format(task.createdAt)}"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                task.isImportant ? Icons.star : Icons.star_border,
                color: Colors.amber,
              ),
              onPressed: onImportant,
            ),
            Checkbox(
              value: task.isBookmarked,
              onChanged: (_) => onBookmark(),
              activeColor: Colors.green,
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            )
          ],
        ),
      ),
    );
  }
}

class ImportantTaskScreen extends StatelessWidget {
  final List<Task> tasks;
  const ImportantTaskScreen({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("⭐ Important Tasks"),
        backgroundColor: Colors.blue.shade500),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: tasks.isEmpty
            ? const Center(child: Text("No important tasks.",
          style: TextStyle(fontSize: 20),))
            : ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) => Card(
            child: ListTile(
              title: Text(tasks[index].title),
              subtitle: Text("Created at: ${DateFormat('hh:mm a').format(tasks[index].createdAt)}"),
            ),
          ),
        ),
      ),
    );
  }
}