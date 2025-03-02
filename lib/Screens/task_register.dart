import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management/Models/task.dart';
import 'package:task_management/Providers/task_provider.dart';

class TaskRegister extends StatefulWidget {
  const TaskRegister({super.key});

  @override
  State<TaskRegister> createState() => _TaskRegisterState();
}

class _TaskRegisterState extends State<TaskRegister> {
  final TextEditingController _titlecontroller = TextEditingController();
  Priority _selectedPriority = Priority.low;
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
   

    return Scaffold(
      appBar: AppBar(title: Text('Add a task'), elevation: 4),
      body: Padding(
        padding: const EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 8),
        child: Column(
          children: [
            //task details
            TextField(
              controller: _titlecontroller,
              decoration: InputDecoration(
                label: Text('Task Title'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),

            const SizedBox(height: 10),
            //priority set
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 55,
                  width: 200,
                  child: DropdownButton<Priority>(
                    borderRadius: BorderRadius.circular(20),
                    value: _selectedPriority,
                    isExpanded: true,
                    items:
                        Priority.values.map((priority) {
                          return DropdownMenuItem<Priority>(
                            value: priority,
                            child: Row(
                              children: [
                                Icon(
                                  priority == Priority.low
                                      ? Icons.priority_high
                                      : priority == Priority.medium
                                      ? Icons.access_time
                                      : priority == Priority.high
                                      ? Icons.error
                                      : Icons.warning,
                                  color:
                                      priority == Priority.low
                                          ? Colors.green
                                          : priority == Priority.medium
                                          ? Colors.blue
                                          : priority == Priority.high
                                          ? Colors.orange
                                          : Colors.red,
                                ),
                                SizedBox(width: 8),
                                Text(priority.label),
                              ],
                            ),
                          );
                        }).toList(),
                    onChanged: (priority) {
                      if (priority != null) {
                        setState(() {
                          _selectedPriority = priority;
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(width: 10),
                //due date
                TextButton.icon(
                  onPressed: () async {
                    DateTime? selected = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (selected != null && selected != _selectedDate) {
                      _selectedDate = selected;
                    }
                  },
                  label: Text("Pick Due Date"),
                ),
              ],
            ),

            const SizedBox(height: 10),
            //add or cancel button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    final task = Task(
                      name: _titlecontroller.text,
                      duedate: _selectedDate,
                      priority: _selectedPriority,
                      isCompleted: false,
                    );
                    Navigator.pop(context, task);
                  },
                  child: Text('Add'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
