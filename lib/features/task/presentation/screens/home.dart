import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmate/core/constants/strings.dart';
import 'package:taskmate/features/task/presentation/controllers/auth_controller.dart';
import 'package:taskmate/features/task/presentation/screens/task_edit.dart';

import '../../../../core/constants/colors.dart';
import '../../data/models/task.dart';
import '../controllers/task_controller.dart';
import '../widgets/task_tile.dart';

class HomeScreen extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  final TaskController taskController = Get.find<TaskController>();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox(
        height: height,
        width: width,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: 150,
              width: width,
              color: AppColors.primaryColor,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 40,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(),
                        Text(
                          AppStrings.homeTitle,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            authController.signOut();
                          },
                          child: Icon(Icons.logout, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: height - 100,
                width: width,
                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: StreamBuilder<List<Task>>(
                    stream: taskController.tasksStream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // return Center(child: SpinKitFadingCircle(color: Colors.blue));
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      final tasks = snapshot.data ?? [];
                      return GetBuilder<TaskController>(
                        builder: (controller) {
                          return tasks.isEmpty
                              ? Center(child: Text('No tasks yet'))
                              : ListView.builder(
                                  itemCount: tasks.length,
                                  itemBuilder: (context, index) {
                                    return TaskTile(
                                      task: tasks[index],
                                      onToggle: () {
                                        tasks[index].isCompleted =
                                            !tasks[index].isCompleted;
                                        controller.updateTask(tasks[index]);
                                      },
                                      onEdit: () {
                                        Get.to(
                                          () => TaskEditScreen(
                                            task: tasks[index],
                                          ),
                                        );
                                      },
                                      onDelete: () {
                                        controller.deleteTask(tasks[index].id);
                                      },
                                    );
                                  },
                                );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => TaskEditScreen());
        },
        backgroundColor: AppColors.secondaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
