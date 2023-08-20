import 'package:task_manager/client/http_client.dart';
import 'package:task_manager/client/model/request.dart';
import 'package:task_manager/pages/home/data/i_task_repository.dart';
import 'package:task_manager/pages/models/task.dart';

class TaskRepository extends ITaskRepository {
  static final RequestAPI _requestAPI = RequestAPI();

  @override
  Future<List<TaskModel>> getAllTask(RequestModel request) async {
    try {
      final response = await _requestAPI.send(request);

      final tasks =
          (response as List).map((task) => TaskModel.fromJson(task)).toList();

      return tasks;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TaskModel> getSelectedTask(RequestModel request) async {
    final response = await _requestAPI.send(request);

    final task = TaskModel.fromJson(response);

    return task;
  }

  @override
  Future<String> deleteTask(RequestModel request) async {
    final response = await _requestAPI.send(request);

    return response['message'];
  }

  @override
  Future<Map<String, dynamic>> createTask(RequestModel request) async {
    final response = await _requestAPI.send(request);

    return {
      'message': response['message'],
      'task': TaskModel.fromJson(response['data']),
    };
  }

  @override
  Future<String> updateTask(RequestModel request) async {
    final response = await _requestAPI.send(request);

    return response['message'];
  }
}
