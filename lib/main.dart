import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmate/features/task/presentation/screens/root.dart';

import 'core/config/binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBindings(),

      home: RootScreen(),
    ),
  );
}
