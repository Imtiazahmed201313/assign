import 'package:flutter/material.dart';

void main() {
  runApp(TaskManagementApp());
}

class TaskManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaskListScreen(),
    );
  }
}

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> tasks = [];

  void addTask(Task task) {
    setState(() {
      tasks.add(task);
    });
  }

  void deleteTask(Task task) {
    setState(() {
      tasks.remove(task);
    });
  }

  void showTaskDetails(Task task) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Task Details",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15.0,),
              Text(
                "Title: ${task.title}",
                style: TextStyle(fontSize: 16),

              ),
              Text(
                "Description: ${task.description}",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "Days Required: ${task.requiredDays}",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16.0),
              Container(height: 40,width: 80,
                child: ElevatedButton(
                  onPressed: () {
                    deleteTask(task);
                    Navigator.pop(context);
                  },
                  child: Text('Delete'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String title = '';
        String description = '';
        String requiredDays = '';

        return AlertDialog(
          title: Text('Add Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  title = value;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title',
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                onChanged: (value) {
                  description = value;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),

                  labelText: 'Description',
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                onChanged: (value) {
                  requiredDays = value ;
                },
                decoration: InputDecoration(
                    labelText: 'Required Days',
                    border: OutlineInputBorder()
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                addTask(Task(title: title, description: description, requiredDays: requiredDays));
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Management'),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(tasks[index].title),
            subtitle: Text(tasks[index].description),
            onTap: () {
              showTaskDetails(tasks[index]);
            },
            onLongPress: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    child: Wrap(
                      children: [
                        ListTile(
                          leading: Icon(Icons.delete),
                          title: Text('Delete Task'),
                          onTap: () {
                            deleteTask(tasks[index]);
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddTaskDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}

class Task {
  final String title;
  final String description;
  final String requiredDays;

  Task({required this.title, required this.description, required this.requiredDays});
}
