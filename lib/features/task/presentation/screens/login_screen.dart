import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmate/core/constants/colors.dart';
import 'package:taskmate/core/constants/strings.dart';

import '../controllers/auth_controller.dart';
import 'signup_screen.dart';

class LoginScreen extends StatelessWidget {
  final AuthController _controller = Get.put(AuthController());
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: height,
        width: width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.4,
                  width: width,
                  child: Image.asset(AppStrings.authVector, fit: BoxFit.cover),
                ),
                SizedBox(height: 30),

                Text(
                  AppStrings.loginWish,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 30,
                    color: AppColors.black,
                  ),
                ),
                Text(
                  "Sign in to Continue",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 30),

                GetBuilder<AuthController>(
                  builder: (controller) {
                    return Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.grey),
                            floatingLabelStyle: TextStyle(
                              color: AppColors.black, // When focused
                              fontWeight: FontWeight.normal,
                            ),

                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade200,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Colors.grey),

                            floatingLabelStyle: TextStyle(
                              color: AppColors.black, // When focused
                              fontWeight: FontWeight.normal,
                            ),

                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade200,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                          obscureText: true,
                        ),
                        SizedBox(height: height * 0.07),
                        controller.isLoading
                            ? CircularProgressIndicator()
                            : SizedBox(
                                height: 50,
                                width: width,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  onPressed: () => controller.login(
                                    _emailController.text,
                                    _passwordController.text,
                                  ),
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                        TextButton(
                          onPressed: () => Get.to(() => SignupScreen()),
                          child: Text(
                            'Create an account',
                            style: TextStyle(color: AppColors.primaryColor),
                          ),
                        ),

                        if (controller.error != null)
                          Text(
                            controller.error!,
                            style: TextStyle(color: Colors.red),
                          ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
