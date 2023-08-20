import 'package:equatable/equatable.dart';

enum TaskStatus {
  completed('completed'),
  incomplete('incomplete');

  const TaskStatus(this.stat);
  final String stat;
}

class TaskModel extends Equatable {
  final int id;
  final String title;
  final String description;
  final String dueDate;
  final String dateCreated;
  final String status;

  const TaskModel({
    this.id = 0,
    required this.title,
    required this.description,
    required this.dueDate,
    this.dateCreated = '',
    this.status = 'incomplete', // Completed/Incomplete
  });

  @override
  List<Object> get props => [
        id,
        title,
        description,
        dueDate,
        dateCreated,
        status,
      ];

  TaskModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        description = json['description'],
        dueDate = json['due_date'],
        dateCreated = json['date_created'],
        status = json['status'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'due_date': dueDate,
        'status': status,
      };
}
