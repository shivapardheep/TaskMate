import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import 'signup_screen.dart';

class LoginScreen extends StatelessWidget {
  final AuthController _controller = Get.put(AuthController());
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: GetBuilder<AuthController>(
          builder: (controller) {
            return Column(
              children: [
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                SizedBox(height: 16),
                controller.isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () => controller.login(
                          _emailController.text,
                          _passwordController.text,
                        ),
                        child: Text('Login'),
                      ),
                TextButton(
                  onPressed: () => Get.to(() => SignupScreen()),
                  child: Text('Create an account'),
                ),
                if (controller.error != null)
                  Text(controller.error!, style: TextStyle(color: Colors.red)),
              ],
            );
          },
        ),
      ),
    );
  }
}
