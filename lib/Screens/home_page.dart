import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_management/Models/task.dart';
import 'package:task_management/Providers/task_provider.dart';
import 'package:task_management/Screens/task_register.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Task Management'), elevation: 4),

      body: Expanded(
      
        child: Consumer<TaskProvider>(
          builder: (context, taskProvider, _) {
            return ListView.builder(
              itemCount: taskProvider.tasks.length,
              itemBuilder: (context, index) {
                Task task = taskProvider.tasks[index];
                return Card(
                  margin: EdgeInsets.all(8),
                  child: Dismissible(
                    key: ObjectKey(index),
                    onDismissed: (direction) {
                      taskProvider.removeTask(index);
                    },
                    child: ListTile(
                      title: Text(
                        task.name,
                        style: TextStyle(
                          decoration:
                              task.isCompleted
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                        ),
                      ),
                      subtitle: Text(
                        "${task.priority.label} - Due:${DateFormat('dd/MM/yyyy').format(task.duedate)}",
                      ),
                      trailing: Checkbox(
                        value: task.isCompleted,
                        onChanged: (value) {
                          setState(() {
                            task.isCompleted = value!;
                          });
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        onPressed: () async {
          final newTask = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TaskRegister()),
          );

          if (newTask != null) {
            Provider.of<TaskProvider>(context, listen: false).addtask(newTask);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
