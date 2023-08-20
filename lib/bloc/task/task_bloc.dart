import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/client/model/request.dart';
import 'package:task_manager/pages/home/data/i_task_repository.dart';
import 'package:task_manager/pages/models/task.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final ITaskRepository _iTaskRepository;
  TaskBloc(ITaskRepository iTaskRepository)
      : _iTaskRepository = iTaskRepository,
        super(TaskInitial()) {
    on<GetAllTasks>((event, emit) => _getAllTask(event, emit));
    on<DeleteTask>((event, emit) => _deleteTask(event, emit));
    on<CreateTask>((event, emit) => _createTask(event, emit));
    on<UpdateTask>((event, emit) => _updateTask(event, emit));
  }

  _getAllTask(GetAllTasks event, Emitter<TaskState> emit) async {
    emit(FetchingTasks());

    try {
      List<TaskModel> tasks = await _iTaskRepository.getAllTask(
        const RequestModel(
          endpoint: 'tasks',
          type: RequestType.get,
          url: ApiOf.internal,
        ),
      );
      emit(TasksFetched(tasks: tasks));
    } catch (e) {
      log('TasksFetchErr: $e');
      emit(TasksFetchErr(error: '$e'));
    }
  }

  _deleteTask(DeleteTask event, Emitter<TaskState> emit) async {
    emit(DeletingTask());

    try {
      String message = await _iTaskRepository.deleteTask(RequestModel(
        url: ApiOf.internal,
        type: RequestType.delete,
        endpoint: 'tasks/${event.id}',
      ));

      emit(TaskDeleted(message: message));
    } catch (e) {
      emit(TaskDeleteErr(error: '$e'));
    }
  }

  _createTask(CreateTask event, Emitter<TaskState> emit) async {
    emit(CreatingTask());
    try {
      var res = await _iTaskRepository.createTask(RequestModel(
        url: ApiOf.internal,
        endpoint: 'tasks',
        type: RequestType.post,
        data: event.task.toJson(),
      ));
      emit(TaskCreated(message: res['message'], task: res['task']));
    } catch (e) {
      emit(CreateTaskErr(error: '$e'));
    }
  }

  _updateTask(UpdateTask event, Emitter<TaskState> emit) async {
    emit(UpdatingTask());
    try {
      var res = await _iTaskRepository.updateTask(RequestModel(
        url: ApiOf.internal,
        endpoint: 'tasks/${event.task.id}',
        type: RequestType.patch,
        data: event.task.toJson(),
      ));

      emit(TaskUpdated(message: res, task: event.task));
    } catch (e) {
      emit(UpdateTaskErr(error: '$e'));
    }
  }
}
