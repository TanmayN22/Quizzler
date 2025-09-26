import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizller/controllers/auth/auth_controller.dart';
import 'package:quizller/utils/constants/sizes.dart';
import 'package:quizller/utils/helpers/helpers.dart';
import 'package:quizller/utils/helpers/responsive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, this.onTap});

  final void Function()? onTap;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();

  void login() async {
    // loading circle
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      final authController = Get.find<AuthController>();
      await authController.login(
          emailcontroller.text.trim(), passwordcontroller.text.trim());
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      displayErrorMsg(e.message ?? 'Unknown error', context);
    }
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace.w),
            child: Column(
              children: [
                SizedBox(height: 120.h),
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppSizes.radiusLg.w),
                  child: Image.asset(
                    'assets/app_icon.png',
                    height: 70.h,
                    width: 70.h,
                  ),
                ),
                SizedBox(height: AppSizes.spaceBtwItems.h),
                Text(
                  'Welcome back to Quizzler',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  'Log In',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: colorScheme.primary,
                      ),
                ),
                SizedBox(height: AppSizes.spaceBtwSections.h),
                Column(
                  children: [
                    TextField(
                      controller: emailcontroller,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(AppSizes.radiusMd.w),
                        ),
                      ),
                    ),
                    SizedBox(height: AppSizes.spaceBtwItems.h),
                    TextField(
                      controller: passwordcontroller,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(AppSizes.radiusMd.w),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () async {
                          final email = emailcontroller.text.trim();
                          if (email.isNotEmpty) {
                            final authController = Get.find<AuthController>();
                            await authController.resetPassword(email);
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Password reset email sent!')),
                              );
                            }
                          } else {
                            displayErrorMsg(
                                'Enter your email to reset password', context);
                          }
                        },
                        child: const Text('Forgot Password?')),
                  ],
                ),
                SizedBox(height: AppSizes.spaceBtwItems.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: login,
                    child: const Text('Login'),
                  ),
                ),
                SizedBox(height: AppSizes.spaceBtwItems.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    SizedBox(width: AppSizes.p4.w),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Sign Up',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.primary,
                            ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSizes.spaceBtwSections.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
