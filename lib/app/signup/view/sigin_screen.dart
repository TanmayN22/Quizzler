import 'package:flutter/material.dart';
import 'package:quizller/utils/constants/sizes.dart';
import 'package:quizller/utils/helpers/responsive.dart';
import 'package:quizller/utils/helpers/helpers.dart';
import 'package:get/get.dart';
import 'package:quizller/controllers/auth/auth_controller.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key, this.onTap});

  final void Function()? onTap;

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  void sigInUser() async {
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    // make sure passwords match
    if (passwordcontroller.text != confirmPasswordController.text) {
      // pop loading circle
      Navigator.pop(context);
      // display error msg
      displayErrorMsg("Password doesn't match", context);
      return;
    } else {
      // try creating an user
      try {
        // create an user
        final authController = Get.find<AuthController>();
        await authController.createAccount(
          emailcontroller.text.trim(),
          passwordcontroller.text.trim(),
        );
        await authController.updateUsername(usernameController.text.trim());
        // pop loading screen
        if (context.mounted) Navigator.pop(context);
      } catch (e) {
        Navigator.pop(context);
        displayErrorMsg(e.toString(), context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          // Add padding around the entire form for a better look
          child: Padding(
            padding: EdgeInsets.all(AppSizes.defaultSpace.w),
            child: Column(
              children: [
                SizedBox(height: 60.h),
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
                  'Welcome to Quizzler',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  'Sign In',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: colorScheme.primary,
                      ),
                ),
                SizedBox(height: AppSizes.spaceBtwSections.h),

                // --- Form Fields ---
                Column(
                  children: [
                    TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        hintText: 'Username',
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(AppSizes.radiusMd.w),
                        ),
                      ),
                    ),
                    SizedBox(height: AppSizes.spaceBtwItems.h),
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
                    SizedBox(height: AppSizes.spaceBtwItems.h),
                    TextField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Confirm Password',
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(AppSizes.radiusMd.w),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSizes.spaceBtwSections.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: sigInUser,
                    child: const Text('Signup'),
                  ),
                ),
                SizedBox(height: AppSizes.spaceBtwItems.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?'),
                    SizedBox(width: AppSizes.p4.w),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Login',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.primary,
                            ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
