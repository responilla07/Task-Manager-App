import 'package:task_manager/client/model/request.dart';
import 'package:task_manager/pages/models/task.dart';

abstract class ITaskRepository {
  Future<List<TaskModel>> getAllTask(RequestModel request);
  Future<TaskModel> getSelectedTask(RequestModel request);
  Future<String> deleteTask(RequestModel request);
  Future<Map<String, dynamic>> createTask(RequestModel request);
  Future<String> updateTask(RequestModel request);
}
