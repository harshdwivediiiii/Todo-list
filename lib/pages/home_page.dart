import 'package:flutter/material.dart';
import 'package:flutterlearn/models/task_model.dart';
import 'package:flutterlearn/utils/todo_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  String selectedCategory = "Work"; // Default category

  List<Task> toDoList = [
    Task(title: "Build a Flutter App", isCompleted: true, category: "Work", tagColor: "#42A5F5"),
    Task(title: "Buy Groceries", isCompleted: false, category: "Shopping", tagColor: "#26A69A"),
    Task(title: "Workout", isCompleted: false, category: "Health", tagColor: "#AB47BC"),
    Task(title: "Read a Book", isCompleted: true, category: "Personal", tagColor: "#FFA726"),
  ];

  void checkBoxChanged(int index) {
    setState(() {
      toDoList[index].isCompleted = !toDoList[index].isCompleted;
    });
  }

  void saveNewTask() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        toDoList.add(Task(
          title: _controller.text,
          isCompleted: false,
          category: selectedCategory,
          tagColor: categoryColor(selectedCategory),
        ));
        _controller.clear();
      });
    }
  }

  void deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
    });
  }

  String categoryColor(String category) {
    switch (category) {
      case "Work":
        return "#42A5F5"; // Blue
      case "Shopping":
        return "#26A69A"; // Teal
      case "Health":
        return "#AB47BC"; // Purple
      case "Personal":
        return "#FFA726"; // Orange
      default:
        return "#90A4AE"; // Gray
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade50, // Light blue background
      appBar: AppBar(
        title: const Text("Simple Todo"),
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.white,
        elevation: 5,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Add a new task...",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: selectedCategory,
                  items: ["Work", "Shopping", "Health", "Personal"].map((String category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCategory = newValue!;
                    });
                  },
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: saveNewTask,
                  backgroundColor: Colors.lightBlue,
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: toDoList.length,
              itemBuilder: (context, index) {
                return TodoList(
                  taskName: toDoList[index].title,
                  taskCompleted: toDoList[index].isCompleted,
                  onChanged: (value) => checkBoxChanged(index),
                  deleteFunction: (context) => deleteTask(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
