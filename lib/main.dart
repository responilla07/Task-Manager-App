import 'package:flutter/material.dart';
import 'package:task_manager/pages/home/home_screen.dart';
import 'package:task_manager/utils/theme.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: AppTheme.lightTheme,
      home: const MyHomePage(title: 'Task Manager Home Page'),
    );
  }
}
