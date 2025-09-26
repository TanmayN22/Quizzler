import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // Reactive user
  //It allows the UI to automatically rebuild whenever the user's auth state changes (e.g., login, logout).
  final Rxn<User> firebaseUser = Rxn<User>();

  // every time a user logs in or out, firebaseUser is updated reactively across the app
  @override
  void onInit() {
    super.onInit();
    firebaseUser.bindStream(firebaseAuth.authStateChanges());
  }

  User? get user => firebaseUser.value;

  Future<void> login(String email, String password) async {
    await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> createAccount(String email, String password) async {
    await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  Future<void> resetPassword(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> updateUsername(String username) async {
    await firebaseAuth.currentUser?.updateDisplayName(username);
  }

  Future<void> deleteAccount(String email, String password) async {
    AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);
    await firebaseAuth.currentUser!.reauthenticateWithCredential(credential);
    await firebaseAuth.currentUser!.delete();
  }

  Future<void> resetPasswordFromCurrentPassword({
    required String currentPassword,
    required String newPassword,
    required String email,
  }) async {
    AuthCredential credential = EmailAuthProvider.credential(email: email, password: currentPassword);
    await firebaseAuth.currentUser!.reauthenticateWithCredential(credential);
    await firebaseAuth.currentUser!.updatePassword(newPassword);
  }
  
}
