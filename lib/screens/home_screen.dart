import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../db/db_helper.dart';
import '../models/task_model.dart';
import '../widgets/task_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum TaskView { all, pending, completed }

class _HomeScreenState extends State<HomeScreen> {
  List<Task> _tasks = [];
  TaskView _currentView = TaskView.all;

  @override
  void initState() {
    super.initState();
    _loadTasksFromDB();
  }

  Future<void> _loadTasksFromDB() async {
    final tasks = await DBHelper.getAllTasks();
    setState(() {
      _tasks = tasks;
    });
  }

  void _addTaskDialog() {
    final TextEditingController _controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.blue.shade200,
        title: const Text("New Task"),
        content: TextField(
          controller: _controller,
          decoration: const InputDecoration(hintText: "Enter a task"),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
            style:ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade300
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              final text = _controller.text.trim();
              if (text.isNotEmpty) {
                final DateTime currentTime = DateTime.now();
                final newTask = Task(title: text, createdAt: currentTime);
                await DBHelper.insertTask(newTask);
                await DBHelper.insertTask(newTask);
                _loadTasksFromDB();
              }
              Navigator.pop(context);
            },
            child: const Text("Add"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade300),
          )
        ],
      ),
    );
  }

  void _toggleBookmark(int index) async {
    final task = _tasks[index];
    task.isBookmarked = !task.isBookmarked;
    task.completedAt = task.isBookmarked ? DateTime.now() : null;
    await DBHelper.updateTask(task);
    _loadTasksFromDB();
  }

  void _toggleImportant(int index) async {
    final task = _tasks[index];
    task.isImportant = !task.isImportant;
    await DBHelper.updateTask(task);
    _loadTasksFromDB();
  }

  void _deleteTask(int index) async {
    final taskId = _tasks[index].id;
    if (taskId != null) {
      await DBHelper.deleteTask(taskId);
      _loadTasksFromDB();
    }
  }

  List<Task> get _filteredTasks {
    switch (_currentView) {
      case TaskView.pending:
        return _tasks.where((t) => !t.isBookmarked).toList();
      case TaskView.completed:
        return _tasks.where((t) => t.isBookmarked).toList();
      default:
        return _tasks;
    }
  }

  @override
  Widget build(BuildContext context) {
    final int pendingCount = _tasks.where((t) => !t.isBookmarked).length;
    final int completedCount = _tasks.where((t) => t.isBookmarked).length;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        backgroundColor: Colors.blue.shade500,
        title: Column(
          children: [
            const Text("📝 To Do Task", style: TextStyle(fontSize: 25,
                fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text("Pending tasks: $pendingCount    "
                "Completed tasks: $completedCount",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(44), // increased height to fit Divider + icons
          child: Column(
            children: [
              // Horizontal line at top of icon buttons
              Container(
                height: 1,
                color: Colors.black,
              ),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.timer,color: Colors.black87,),
                      tooltip: 'Pending Tasks',
                      onPressed: () => setState(() => _currentView = TaskView.pending),
                    ),
                    Container(
                      width: 1,
                      color: Colors.black,
                    ),
                    IconButton(
                      icon: const Icon(Icons.check_circle, color: Colors.black87,),
                      tooltip: 'Completed Tasks',
                      onPressed: () => setState(() => _currentView = TaskView.completed),
                    ),
                    Container(
                      width: 1,
                      color: Colors.black,
                    ),
                    IconButton(
                      icon: const Icon(Icons.star,color: Colors.black87,),
                      tooltip: 'Important Tasks',
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ImportantTaskScreen(
                              tasks: _tasks.where((task) => task.isImportant).toList(),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _filteredTasks.isEmpty
            ? const Center(child: Text("No tasks available.",
          style: TextStyle(fontSize: 20),))
            : ListView.builder(
          itemCount: _filteredTasks.length,
          itemBuilder: (context, index) {
            final task = _filteredTasks[index];
            final realIndex = _tasks.indexOf(task);
            return TaskTile(
              task: task,
              onBookmark: () => _toggleBookmark(realIndex),
              onImportant: () => _toggleImportant(realIndex),
              onDelete: () => _deleteTask(realIndex),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addTaskDialog,
        backgroundColor: Colors.blue.shade200,
        icon: const Icon(Icons.add ),
        label: Text('Add Task'),
      ),
    );
  }
}
