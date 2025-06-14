import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../controllers/task_controller.dart';
import 'home.dart';
import 'login_screen.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (authController) {
        // Don't instantiate HomeScreen immediately!
        if (authController.currentUser != null) {
          return const _HomeWrapper();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}

class _HomeWrapper extends StatelessWidget {
  const _HomeWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskController>(
      builder: (controller) {
        return HomeScreen(); // ✅ This ensures TaskController is available first
      },
    );
  }
}
