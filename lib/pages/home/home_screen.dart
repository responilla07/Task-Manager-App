import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/pages/home/data/task_repository.dart';
import 'package:task_manager/pages/home/widgets/animated_list_item.dart';
import 'package:task_manager/pages/home/widgets/home_loader.dart';
import 'package:task_manager/pages/home/widgets/tasks_empty.dart';
import 'package:task_manager/pages/models/global_data.dart';
import 'package:task_manager/pages/models/task.dart';
import 'package:task_manager/pages/tasks/create_update_task.dart';
import 'package:task_manager/pages/tasks/task_details.dart';
import 'package:task_manager/utils/theme.dart';

import '../../bloc/bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _listKey = GlobalKey<AnimatedListState>();
  final TaskBloc _taskBloc = TaskBloc(TaskRepository());
  final List<TaskModel> _tasks = [];

  Future<void> _createNewTask() async {
    log('create new task...');
    navigatorPush(
      context: context,
      name: 'CreateUpdateTask',
      widget: CreateUpdateTask(taskBloc: _taskBloc),
    );
  }

  Future<void> _openUpdateTask(TaskModel taskModel) async {
    log('_openUpdateTask...');
    navigatorPush(
      context: context,
      name: 'CreateUpdateTask',
      widget: CreateUpdateTask(taskModel: taskModel, taskBloc: _taskBloc),
    );
  }

  Future<void> _removeTask(int index, TaskModel task) async {
    _taskBloc.add(DeleteTask(id: task.id));
    _listKey.currentState!.removeItem(
      index,
      (context, animation) => AnimatedListItem(
        taskModel: task,
        animation: animation,
      ),
      duration: const Duration(milliseconds: 300),
    );
    _tasks.removeAt(index);
  }

  Future<void> _insertNewTask(TaskModel task) async {
    int index = 0;
    _listKey.currentState!.insertItem(index);
    _tasks.insert(index, task);
  }

  Future<void> _markTask(int index, TaskModel task) async {
    task = TaskModel(
      title: task.title,
      description: task.description,
      dueDate: task.dueDate,
      dateCreated: task.dateCreated,
      id: task.id,
      status:
          task.status == TaskStatus.completed.name ? 'incomplete' : 'completed',
    );
    _taskBloc.add(UpdateTask(task: task));
    _tasks[index] = task;
  }

  @override
  void initState() {
    _taskBloc.add(GetAllTasks());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<TaskBloc, TaskState>(
          bloc: _taskBloc,
          listener: _taskListener,
          builder: (context, state) {
            if (state is FetchingTasks) return const HomeLoader();
            if (_tasks.isEmpty) {
              return const TasksEmpty();
            }

            return _tasksList();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewTask,
        tooltip: 'Create task',
        elevation: 8,
        child: const Image(image: AssetImage('assets/writing.png')),
      ),
    );
  }

  _taskListener(BuildContext context, TaskState state) {
    if (state is TasksFetched) {
      setState(() => _tasks.addAll(state.tasks));
    }
    if (state is TaskDeleted) {
      setState(() {});
    }

    if (state is TaskCreated) {
      showScaffoldMessage(
        context: context,
        color: AppColors.green,
        message: state.message,
      );
      _insertNewTask(state.task);
    }

    if (state is TaskUpdated) {
      showScaffoldMessage(
        context: context,
        color: AppColors.green,
        message: state.message,
      );
    }

    if (state is CreateTaskErr) {
      showScaffoldMessage(
        context: context,
        message: state.error,
      );
    }

    if (state is TaskDeleted) {
      showScaffoldMessage(
        context: context,
        message: state.message,
        color: AppColors.orage,
      );
    }

    if (state is UpdateTaskErr) {
      showScaffoldMessage(
        context: context,
        message: state.error,
      );
    }
  }

  Widget _tasksList() {
    return AnimatedList(
      key: _listKey,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      initialItemCount: _tasks.length,
      itemBuilder: (context, index, animation) {
        TaskModel task = _tasks[index];
        return Padding(
          padding: EdgeInsets.only(
            bottom: (index == (_tasks.length - 1)) ? 64 : 1,
          ),
          child: AnimatedListItem(
            key: ValueKey(task.id),
            animation: animation,
            onClicked: () {
              navigatorPush(
                context: context,
                name: 'TaskDetails',
                widget: TaskDetails(task: task),
              );
            },
            onEdit: () {
              Navigator.pop(context);
              _openUpdateTask(task);
            },
            onDelete: () {
              Navigator.pop(context);
              _removeTask(index, task);
            },
            onMarkSelected: () {
              Navigator.pop(context);
              _markTask(index, task);
            },
            taskModel: task,
          ),
        );
      },
    );
  }
}
