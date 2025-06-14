import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/task.dart';

class TaskService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createTask(Task task) async {
    await _firestore.collection('tasks').doc(task.id).set(task.toJson());
  }

  Stream<List<Task>> getTasks(String userId) {
    return _firestore
        .collection('tasks')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) => Task.fromJson(doc.data())).toList();
        });
  }

  Future<void> updateTask(Task task) async {
    await _firestore.collection('tasks').doc(task.id).update(task.toJson());
  }

  Future<void> deleteTask(String taskId) async {
    await _firestore.collection('tasks').doc(taskId).delete();
  }
}
