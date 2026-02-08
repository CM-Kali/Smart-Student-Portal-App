import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  /// ✅ Check Auth and Redirect (called from Splash)
  Future<void> checkAuthAndRedirect() async {
    await Future.delayed(const Duration(seconds: 3));
    final user = auth.currentUser;
    if (user == null) {
      Get.offAllNamed('/login');
    } else {
      Get.offAllNamed('/home');
    }
  }

  /// REGISTER
  Future<void> register(String name, String email, String password, String rollNo) async {
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await firestore.collection('students').doc(userCredential.user!.uid).set({
        'name': name,
        'email': email,
        'roll_no': rollNo,
        'semester': "BSCS-6",
        'profile_pic': '',
        'subjects': [
          "App Dev",
          "Web Dev",
          "AI Lab",
          "AI Theory",
          "Computer Networks",
          "Computer Networks Lab",
          "Technical Writing",
          "Community Service"
        ],
        'assignments': [],
        'attendance': [],
        'courses': [],
        'created_at': FieldValue.serverTimestamp(),
      });

      Get.offAllNamed('/home');
      Get.snackbar("Success", "Account created successfully");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  /// LOGIN
  Future<void> login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  /// LOGOUT
  Future<void> logout() async {
    await auth.signOut();
    Get.offAllNamed('/login');
  }

  /// RESET PASSWORD
  Future<void> resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      Get.snackbar("Success", "Password reset email sent");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
