enum Priority { low, medium, high }

extension TaskPriorityExtension on Priority {
  String get label {
    switch (this) {
      case Priority.low:
        return "Low";
      case Priority.medium:
        return "Medium";
      case Priority.high:
        return "High";
    }
  }
}

class Task {
  final String name;
  final DateTime duedate;
  final Priority priority;
  bool isCompleted = false;

  Task({
    required this.isCompleted,
    required this.name,
    required this.duedate,
    required this.priority,
  });

  Map<String, dynamic> tojson() {
    return {
      'name': name,
      'duedate': duedate.toIso8601String(),
      'priority': priority.index,
      'iscompleted' : isCompleted,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      name: json['name'],
      duedate: DateTime.parse(json['duedate']),
      priority: Priority.values[json['priority']],
      isCompleted: json['iscompleted'],
    );
  }
}
