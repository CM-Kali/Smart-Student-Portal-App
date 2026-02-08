import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  /// Firebase user state
  Rx<User?> firebaseUser = Rx<User?>(null);

  @override
  void onReady() {
    super.onReady();
    firebaseUser.bindStream(auth.userChanges());
  }

  /// Simple login check (used by Splash)
  bool get isLoggedIn => firebaseUser.value != null;

  // ---------------- AUTH METHODS ----------------

  /// Register user + create Firestore record
  Future<void> register(
      String name,
      String email,
      String password,
      String rollNo,
      ) async {
    try {
      UserCredential userCredential =
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await firestore.collection('students')
          .doc(userCredential.user!.uid)
          .set({
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
      });

      Get.snackbar("Success", "Account created successfully");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  /// Login
  Future<void> login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  /// Logout
  Future<void> logout() async {
    try {
      await auth.signOut();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  /// Reset Password ✅ (KEPT)
  Future<void> resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      Get.snackbar(
        "Success",
        "Password reset email sent. Check your inbox.",
      );
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  /// OPTIONAL: Update existing students
  Future<void> updateExistingStudents() async {
    try {
      QuerySnapshot snapshot =
      await firestore.collection('students').get();

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

      Get.snackbar(
        "Success",
        "Existing students updated successfully",
      );
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
