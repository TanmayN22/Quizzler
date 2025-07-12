import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizller/controllers/auth_controller.dart';
import 'package:quizller/utils/helpers/helpers.dart';
// import 'package:get/get.dart';

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
      await authController.login(emailcontroller.text.trim(), passwordcontroller.text.trim());
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      displayErrorMsg(e.message ?? 'Unknow error', context);
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
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),

            // App Icon
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/app_icon.png',
                height: 70,
                width: 70,
              ),
            ),
            const SizedBox(height: 10),

            // Title texts
            const Text(
              'Welcome back to Quizzler',
              style: TextStyle(fontSize: 22),
            ),
            const Text(
              'Log In',
              style: TextStyle(fontSize: 20, color: Colors.deepPurple),
            ),
            const SizedBox(height: 20),

            // Input fields
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                children: [
                  TextField(
                    controller: emailcontroller,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: passwordcontroller,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 200),
              child: TextButton(
                  onPressed: () async {
                    final email = emailcontroller.text.trim();
                    if (email.isNotEmpty) {
                      final authController = Get.find<AuthController>();
                      await authController.resetPassword(email);
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Reset Password email sent to your email')),
                        );
                      }
                    } else {
                      displayErrorMsg('Enter your email to reset your password', context);
                    }
                  },
                  child: Text('Forgot Password?')),
            ),

            const SizedBox(height: 0),

            // Login button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ElevatedButton(
                onPressed: () {
                  // Do sign-in logic
                  login();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 140, vertical: 15),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?"),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    'SignIn',
                    style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}
