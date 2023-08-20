part of 'task_bloc.dart';

sealed class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class GetAllTasks extends TaskEvent {}
class DeleteTask extends TaskEvent {
  final int id;

  const DeleteTask({
    required this.id,
  });

  @override
  List<Object> get props => [];

  @override
  String toString() => 'DeleteTask {}';
}

class CreateTask extends TaskEvent {
  final TaskModel task;

  const CreateTask({
    required this.task,
  });

  @override
  List<Object> get props => [];

  @override
  String toString() => 'CreateTask {}';
}

class UpdateTask extends TaskEvent {
  final TaskModel task;

  const UpdateTask({
    required this.task,
  });

  @override
  List<Object> get props => [];

  @override
  String toString() => 'UpdateTask {}';
}
