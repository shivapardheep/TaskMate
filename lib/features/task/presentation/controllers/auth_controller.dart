import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../data/services/auth_services.dart';
import '../screens/home.dart';
import '../screens/login_screen.dart';

class AuthController extends GetxController {
  final AuthService _authService = Get.put(AuthService());
  bool isLoading = false;
  String? error;

  Future<void> signUp(String email, String password) async {
    isLoading = true;
    error = null;
    update();

    try {
      await _authService.signUp(email, password);
      Get.offAll(() => HomeScreen());
    } catch (e) {
      error = e.toString();
      Get.snackbar('Error', error!);
    }

    isLoading = false;
    update();
  }

  Future<void> login(String email, String password) async {
    isLoading = true;
    error = null;
    update();

    try {
      await _authService.login(email, password);
      Get.offAll(() => HomeScreen());
    } catch (e) {
      error = e.toString();
      Get.snackbar('Error', error!);
    }

    isLoading = false;
    update();
  }

  Future<void> signOut() async {
    await _authService.signOut();
    Get.offAll(() => LoginScreen());
  }

  User? get currentUser => _authService.currentUser;
}
