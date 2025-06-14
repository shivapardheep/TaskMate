import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class SignupScreen extends StatelessWidget {
  final AuthController _controller = Get.put(AuthController());
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
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
                        onPressed: () => controller.signUp(
                          _emailController.text,
                          _passwordController.text,
                        ),
                        child: Text('Sign Up'),
                      ),
                TextButton(
                  onPressed: () => Get.back(),
                  child: Text('Already have an account? Login'),
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
