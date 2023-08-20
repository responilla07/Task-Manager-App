import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/bloc/task/task_bloc.dart';
import 'package:task_manager/pages/models/task.dart';
import 'package:task_manager/pages/widgets/custom_bottom_navigation_button.dart';
import 'package:task_manager/pages/widgets/custom_textfield.dart';

class CreateUpdateTask extends StatefulWidget {
  final TaskModel? taskModel;
  final TaskBloc taskBloc;
  const CreateUpdateTask({
    super.key,
    this.taskModel,
    required this.taskBloc,
  });

  @override
  State<CreateUpdateTask> createState() => _CreateUpdateTaskState();
}

class _CreateUpdateTaskState extends State<CreateUpdateTask> {
  final _formGlobalKey = GlobalKey<FormState>();
  final TextEditingController _taskName = TextEditingController();
  final TextEditingController _taskDescription = TextEditingController();
  final TextEditingController _taskDueDate = TextEditingController();
  DateTime? pickedDate;

  @override
  void initState() {
    _setInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskBloc, TaskState>(
      bloc: widget.taskBloc,
      listener: (context, state) {
        if (state is TaskCreated || state is TaskUpdated) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              widget.taskModel != null ? 'Edit Task' : 'Create new Task',
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formGlobalKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: _taskName,
                    hintText: "Input task name",
                    enabled: state is! CreatingTask || state is! UpdatingTask,
                    validator: (value) {
                      return _validateValue(value!);
                    },
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 200,
                    child: CustomTextField(
                      controller: _taskDescription,
                      hintText: "Input task description",
                      maxLines: 9,
                      enabled: state is! CreatingTask || state is! UpdatingTask,
                      validator: (value) {
                        return _validateValue(value!);
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    onTap: state is! CreatingTask || state is! UpdatingTask
                        ? _showDatePicker
                        : null,
                    controller: _taskDueDate,
                    hintText: "Select task due date",
                    readOnly: true,
                    validator: (value) {
                      return _validateValue(value!);
                    },
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: CustomBottomNavButton(
            btnText: widget.taskModel == null
                ? (state is CreatingTask ? 'Creating task...' : 'CREATE')
                : (state is UpdatingTask ? 'Updating task...' : 'UPDATE'),
            onPressed: _onPressed,
          ),
        );
      },
    );
  }

  _setInitialData() {
    if (widget.taskModel != null) {
      _taskName.text = widget.taskModel!.title;
      _taskDescription.text = widget.taskModel!.description;
      pickedDate = DateTime.tryParse(widget.taskModel!.dueDate);
      _taskDueDate.text = DateFormat("MMM. dd, yyyy").format(pickedDate!);
    }
  }

  String? _validateValue(String value) {
    if (value.isEmpty) {
      return 'This is a required field.';
    }
    return null;
  }

  _showDatePicker() async {
    FocusScope.of(context).unfocus();
    // TimeOfDay? time;

    pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    // .then((value) async {
    //   // if (value != null) {
    //   //   time = await showTimePicker(
    //   //     context: context,
    //   //     initialTime: TimeOfDay.now(),
    //   //   );

    //   //   if (time != null) {
    //   //     pickedDate = value;
    //   //     log(time!.hour.toString());

    //   //     pickedDate = pickedDate!.add(Duration(
    //   //       hours: time!.hour,
    //   //       minutes: time!.minute,
    //   //     ));
    //   //   }
    //   // }
    // });

    if (pickedDate != null) {
      _taskDueDate.text = DateFormat("MMM. dd, yyyy").format(pickedDate!);
    }
  }

  _onPressed() {
    FocusScope.of(context).unfocus();
    if (!_formGlobalKey.currentState!.validate()) return null;

    if (widget.taskModel == null) {
      widget.taskBloc.add(CreateTask(
        task: TaskModel(
          title: _taskName.text,
          description: _taskDescription.text,
          dueDate: pickedDate.toString(),
        ),
      ));
    } else {
      TaskModel? task;

      if (widget.taskModel != null) {
        task = widget.taskModel!;
      }

      if (task != null) {
        widget.taskBloc.add(UpdateTask(
          task: TaskModel(
            title: _taskName.text,
            description: _taskDescription.text,
            dueDate: pickedDate.toString(),
            dateCreated: task.dateCreated,
            id: task.id,
            status: task.status,
          ),
        ));
      }
    }
  }
}
