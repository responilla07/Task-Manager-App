part of 'task_bloc.dart';

sealed class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

final class TaskInitial extends TaskState {}

final class FetchingTasks extends TaskState {}

final class TasksFetched extends TaskState {
  final List<TaskModel> tasks;
  const TasksFetched({required this.tasks});

  @override
  List<Object> get props => [tasks];

  @override
  String toString() => 'TasksFetched { tasks: $tasks }';
}

final class TasksFetchErr extends TaskState {
  final String error;

  const TasksFetchErr({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'TasksFetchErr { error: $error }';
}

final class DeletingTask extends TaskState {}

final class TaskDeleted extends TaskState {
  final String message;
  const TaskDeleted({required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'TasksFetched { message: $message }';
}

final class TaskDeleteErr extends TaskState {
  final String error;

  const TaskDeleteErr({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'TaskDeleteErr { error: $error }';
}

final class CreatingTask extends TaskState {}

final class TaskCreated extends TaskState {
  final String message;
  final TaskModel task;
  const TaskCreated({
    required this.message,
    required this.task,
  });

  @override
  List<Object> get props => [message, task];

  @override
  String toString() => 'TaskCreated { message: $message }';
}

final class CreateTaskErr extends TaskState {
  final String error;

  const CreateTaskErr({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'CreateTaskErr { error: $error }';
}

final class UpdatingTask extends TaskState {}

final class TaskUpdated extends TaskState {
  final String message;
  final TaskModel task;
  const TaskUpdated({
    required this.message,
    required this.task,
  });

  @override
  List<Object> get props => [message, task];

  @override
  String toString() => 'TaskUpdated { message: $message }';
}

final class UpdateTaskErr extends TaskState {
  final String error;

  const UpdateTaskErr({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'UpdateTaskErr { error: $error }';
}
