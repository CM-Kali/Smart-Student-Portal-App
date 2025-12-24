import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Rx<User?> firebaseUser = Rx<User?>(null);

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAllNamed('/login'); // navigate to login if not logged in
    } else {
      Get.offAllNamed('/home'); // navigate to home if logged in
    }
  }

  /// Signup + Firestore student record
  void register(String name, String email, String password, String rollNo) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
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
        'assignments': [], // student assignments
        'attendance': [],  // student attendance
        'courses': [],     // student courses
      });

      Get.snackbar("Success", "Account created successfully");
      Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  /// Login
  void login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      // Firebase user stream will handle navigation
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  /// Logout
  void logout() async {
    try {
      await auth.signOut();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  /// Reset Password
  void resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      Get.snackbar("Success", "Password reset email sent");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  /// OPTIONAL: Update all existing students to full schema
  void updateExistingStudents() async {
    try {
      QuerySnapshot snapshot = await firestore.collection('students').get();

      for (var doc in snapshot.docs) {
        await firestore.collection('students').doc(doc.id).update({
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
        });
      }

      Get.snackbar("Success", "Existing students updated successfully");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
