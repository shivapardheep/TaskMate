import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../data/models/task.dart';
import '../../data/services/auth_services.dart';
import '../../data/services/task_services.dart';

class TaskController extends GetxController {
  final TaskService _taskService = TaskService();
  // final TaskService _taskService = Get.find<TaskService>();
  final AuthService _authService = AuthService();

  bool isLoading = false;
  String? error;

  Stream<List<Task>> get tasksStream =>
      _taskService.getTasks(_authService.currentUser!.uid);

  Future<void> createTask(String title, String description) async {
    if (!_validateInput(title, description)) return;
    isLoading = true;
    error = null;
    update();

    try {
      final task = Task(
        id: Uuid().v4(),
        title: title,
        description: description,
        createdAt: DateTime.now().toString(),
        userId: _authService.currentUser!.uid,
      );

      await _taskService.createTask(task);
    } catch (e) {
      error = e.toString();
      Get.snackbar('Error', error!);
    }

    isLoading = false;
    update();
  }

  Future<void> updateTask(Task task) async {
    if (!_validateInput(task.title, task.description)) return;
    isLoading = true;
    error = null;
    update();

    try {
      await _taskService.updateTask(task);
    } catch (e) {
      error = e.toString();
      Get.snackbar('Error', error!);
    }

    isLoading = false;
    update();
  }

  Future<void> deleteTask(String taskId) async {
    isLoading = true;
    error = null;
    update();

    try {
      await _taskService.deleteTask(taskId);
    } catch (e) {
      error = e.toString();
      Get.snackbar('Error', error!);
    }

    isLoading = false;
    update();
  }

  bool _validateInput(String title, String description) {
    if (title.isEmpty) {
      Get.snackbar('Error', 'Title cannot be empty');
      return false;
    }
    if (description.isEmpty) {
      Get.snackbar('Error', 'Description cannot be empty');
      return false;
    }
    return true;
  }
}
