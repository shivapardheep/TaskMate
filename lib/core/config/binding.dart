import 'package:get/get.dart';
import 'package:taskmate/features/task/data/services/auth_services.dart';

import '../../features/task/data/services/task_services.dart';
import '../../features/task/presentation/controllers/auth_controller.dart';
import '../../features/task/presentation/controllers/task_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(TaskController(), permanent: true);

    Get.put(AuthController(), permanent: true);
    Get.put(TaskService(), permanent: true);
    Get.put(AuthService(), permanent: true);
  }
}
