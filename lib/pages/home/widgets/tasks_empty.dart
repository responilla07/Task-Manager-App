import 'package:flutter/material.dart';
import 'package:task_manager/utils/theme.dart';

class TasksEmpty extends StatelessWidget {
  const TasksEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage('assets/planning.png'),
              opacity: AlwaysStoppedAnimation(.8),
              height: 220,
            ),
            const SizedBox(height: 32),
            Text(
              'No scheduled tasks for now.',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 22,
                color: AppColors.logoPrimary.withOpacity(.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
