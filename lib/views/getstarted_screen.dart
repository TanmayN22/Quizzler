// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class GetstartedScreen extends StatelessWidget {
//   const GetstartedScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             Spacer(),
//             ClipRRect(
//               borderRadius: BorderRadius.circular(60),
//               child: Image.asset(
//                 'assets/app_icon.png',
//                 height: 200,
//                 width: 200,
//               ),
//             ),
//             Spacer(),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   OutlinedButton(
//                     onPressed: () {Get.toNamed('/login-screen');},
//                     child: Text('Login'),
//                   ),
//                   OutlinedButton(
//                       onPressed: () {
//                         Get.toNamed('/signin-screen');
//                       },
//                       child: Text('Sign-In')),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
