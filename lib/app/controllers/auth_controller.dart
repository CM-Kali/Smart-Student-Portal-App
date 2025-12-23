import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var isLoading = false.obs;

  // SIGN UP
  Future<void> signUp(String email, String password) async {
    try {
      isLoading.value = true;
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.offAllNamed('/home');
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Signup Error", e.message ?? "Error");
    } finally {
      isLoading.value = false;
    }
  }

  // LOGIN
  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.offAllNamed('/home');
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Login Error", e.message ?? "Error");
    } finally {
      isLoading.value = false;
    }
  }

  // FORGOT PASSWORD
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Get.snackbar("Success", "Password reset email sent");
      Get.back();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  // LOGOUT
  Future<void> logout() async {
    await _auth.signOut();
    Get.offAllNamed('/login');
  }
}
