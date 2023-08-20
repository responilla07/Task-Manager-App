import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:task_manager/pages/models/task.dart';
import 'package:task_manager/utils/theme.dart';

class TaskDetails extends StatelessWidget {
  final TaskModel task;
  const TaskDetails({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: task.status == TaskStatus.completed.name
                    ? AppColors.green
                    : AppColors.orage,
                borderRadius: const BorderRadius.all(Radius.circular(16)),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 3,
              ),
              child: Text(
                task.status.toLowerCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              task.title,
              style: TextStyle(
                fontSize: 24,
                color: AppColors.primary,
                fontFamily: 'ValeraRound',
                fontWeight: FontWeight.bold,
              ),
            ),
            _dateWidget(),
            const SizedBox(height: 16),
            Text(
              task.description,
              style: TextStyle(
                color: AppColors.grey,
                fontFamily: 'ValeraRound',
              ),
            ),
          ],
        ),
      ),
    );
  }

  _dateWidget() {
    DateFormat dateFormat = DateFormat("MMM. dd, yyyy");
    return Text(
      "Starting at ${dateFormat.format(DateTime.parse(task.dateCreated))} until ${dateFormat.format(DateTime.parse(task.dueDate))}",
      style: TextStyle(color: AppColors.secondaryL),
    );
  }
}
